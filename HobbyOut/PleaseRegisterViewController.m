//
//  PleaseRegisterViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "PleaseRegisterViewController.h"
#import "PleaseRegisterView.h"
#import "EventListViewController.h"

#import "IIViewDeckController.h"
#import "MBProgressHUD.h"

#import "WelcomeViewController.h"


#import <QuartzCore/QuartzCore.h>
#import <FacebookSDK/FacebookSDK.h>

@interface PleaseRegisterViewController ()<UIScrollViewDelegate, LoginServiceDelegate>

@end

@implementation PleaseRegisterViewController

-(id) init
{
    self = [super init];
    
    if (self)
    {
        self.loginFacebookService = [[LoginFacebookService alloc] initWithDelegate:self];
    }
    
    return self;
}

- (void) loadView
{
    self.view = [[PleaseRegisterView alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
    [leftButton setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
    [rightButton setImage:[UIImage imageNamed:@"decoButton.png"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(_logout) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.title = @"Rejoins-nous !";
    
    self.pleaseRegisterView.scrollView.delegate = self;
    [[self pleaseRegisterView].facebookConnectButton addTarget:self action:@selector(_connectToFacebook) forControlEvents:UIControlEventTouchUpInside];
    [[self pleaseRegisterView].registerButton addTarget:self action:@selector(_register) forControlEvents:UIControlEventTouchUpInside];
    
}

- (PleaseRegisterView *) pleaseRegisterView
{
    return (PleaseRegisterView *) self.view;
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = 302; 
    float fractionalPage = self.pleaseRegisterView.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.pleaseRegisterView.pageControl.currentPage = page;
}

#pragma mark Action
-(void) _doLogin
{
    EventListViewController *nextViewController = [[EventListViewController alloc] init];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController setNavigationBarHidden:NO];
   
    [[self navigationController] setViewControllers:[NSArray arrayWithObject:nextViewController]  animated:NO];
}

- (void) _logout
{
    self.viewDeckController.leftController = nil;
    self.viewDeckController.rightController = nil;
    
    [self.navigationController
     setViewControllers:[NSArray arrayWithObject:[[WelcomeViewController alloc] init]]  animated:NO];
}

-(void) _register
{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.hobbyout.com/index.php?option=com_weboomla&view=register&Itemid=285"]];
}

#pragma mark Facebook Login
-(void) _connectToFacebook
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"_connectToFacebook");
    
    
    if (!FBSession.activeSession.isOpen)
    {
        NSLog(@"Session not active");
        [FBSession openActiveSessionWithReadPermissions:[NSArray arrayWithObjects:nil]
         
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          [self _sessionStateChanged:session state:state error:error];
                                      }];
    }
    else
    {
        NSLog(@"Session active");
        [self _requestMe];
    }
}

- (void) _sessionStateChanged:(FBSession *)session state:(FBSessionState)state error:(NSError *)error
{
    NSLog(@"Facebook _sessionStateChanged : state from connect page : %u", state);
    
    switch (state)
    {
        case FBSessionStateOpen:
        {
            NSLog(@"Facebook _sessionStateChanged : FBSessionStateOpen");
            
            [self _requestMe];
            
            FBCacheDescriptor *cacheDescriptor = [FBFriendPickerViewController cacheDescriptor];
            [cacheDescriptor prefetchAndCacheForSession:session];
        }
            break;
            
        case FBSessionStateClosed:
        {
            
            NSLog(@"Facebook _sessionStateChanged : FBSessionStateClosed");
            [FBSession.activeSession closeAndClearTokenInformation];
            
        }
            break;
        case FBSessionStateClosedLoginFailed:
        {
            NSLog(@"Facebook _sessionStateChanged : FBSessionStateClosedLoginFailed");
            [FBSession.activeSession closeAndClearTokenInformation];
        }
            break;
            
        case    FBSessionStateOpenTokenExtended:
        {
            NSLog(@"Facebook _sessionStateChanged : FBSessionStateOpenTokenExtended");
        }
            break;
            
            
        default:
        {
            NSLog(@"Facebook _sessionStateChanged : OTHER");
        }
            break;
    }
}

- (void) _requestMe
{
    NSLog(@"_requestMe");
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection,
                                                           NSDictionary<FBGraphUser> *me,
                                                           NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(error) {
            [self _printError:@"Error requesting /me" error:error];
            return;
        }
        
        NSError* errorJson;
        NSString* jsonString;
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:me options:NSJSONWritingPrettyPrinted error:&errorJson];
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSLog(@"ME : %@", jsonString);
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                jsonString, @"facebook",
                                [[[FBSession activeSession] accessTokenData] accessToken], @"access_token",
                                nil];
        
        
        [self.loginFacebookService postWithParameters:params forView:self.view];
    }];
}

-(void) _printError:(NSString*)message error:(NSError*)error {
    if(message) {
        NSLog(@"%@", message);
    }
    
    // works for 1 FBRequest per FBRequestConnection
    int userInfoCode = [error.userInfo[@"com.facebook.FBiOSSDK:ParsedJSONResponseKey"][0][@"body"][@"error"][@"code"] integerValue];
    NSString* userInfoMessage = error.userInfo[@"com.facebook.FBiOSSDK:ParsedJSONResponseKey"][0][@"body"][@"error"][@"message"];
    
    // outer error
    NSLog(@"Error: %@", error);
    NSLog(@"Error code: %d", error.code);
    NSLog(@"Error message: %@", error.localizedDescription);
    
    // inner error
    NSLog(@"Error code: %d", userInfoCode);
    NSLog(@"Error message: %@", userInfoMessage);
    
    NSString *displayMessage = error.localizedDescription;
    if(userInfoCode == 2500)
    {
        displayMessage = @"Vous n'êtes pas connecté à facebook";
    }
    
    if(error.code == 2)
    {
        displayMessage = @"Vous devez autoriser HobbyOut à se connecter à votre compte facebook";
    }
    
    if(error.code == 5)
    {
        displayMessage = @"Problème réseau, veuillez réessayer lorsque vous aurez une meilleur connexion.";
    }
    
    UIAlertView* view = [[UIAlertView alloc]initWithTitle:@"Facebook"
                                                  message:displayMessage
                                                 delegate:nil
                                        cancelButtonTitle:@"OK"
                                        otherButtonTitles:nil];
    [view show];
}

#pragma mark Service

- (void) loginSucess:(LoginService*)loginService
{
    [self _doLogin];
}

- (void) loginFail:(LoginService*)loginService
{

}

@end
