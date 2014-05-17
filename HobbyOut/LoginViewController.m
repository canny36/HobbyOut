
//
//  LoginViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "LoginViewController.h"
#import "LoginView.h"

#import "TvViewController.h"
#import "MenuViewController.h"

#import "IIViewDeckController.h"

#import "UserDefaultManager.h"

#import "MBProgressHUD.h"
#import "RegisterViewController.h"

#import <FacebookSDK/FacebookSDK.h>


@interface LoginViewController () <UITextFieldDelegate, LoginServiceDelegate>

@end

@implementation LoginViewController

-(id) init
{
    self = [super init];
    
    if (self)
    {
        self.loginService = [[LoginService alloc] initWithDelegate:self];
        self.loginFacebookService = [[LoginFacebookService alloc] initWithDelegate:self];
        
        self.userResetService = [[UserResetService alloc] init];
    }
    
    return self;
}

#pragma mark View
- (void)loadView
{
    self.view = [[LoginView alloc] init];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self loginView].emailTextField.delegate = self;
    [self loginView].passwordTextField.delegate = self;
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    [[self loginView].connectionButton addTarget:self action:@selector(_sendLoginRequest) forControlEvents:UIControlEventTouchUpInside];
    [[self loginView].facebookConntectionButton addTarget:self action:@selector(_connectToFacebook) forControlEvents:UIControlEventTouchUpInside];
    
    [self loginView].lostPassword.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_lostPasstword)];
    [[self loginView].lostPassword addGestureRecognizer:tapGesture];
    
    
    [[self loginView].backButton  addTarget:self action:@selector(_goBack) forControlEvents:UIControlEventTouchUpInside];
    
        [[self loginView].registerButton  addTarget:self action:@selector(_register) forControlEvents:UIControlEventTouchUpInside];
}


-(LoginView *) loginView
{
    return (LoginView *) self.view;
}

#pragma mark Action

-(void)_register{
    RegisterViewController *nextViewController = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:nextViewController animated:YES];
//    CATransition* transition = [CATransition animation];
//    transition.duration = 0.5;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    transition.type = kCATransitionFade;
//    
//    [self.navigationController.view.layer addAnimation:transition forKey:nil];
//    
//    [self.navigationController setNavigationBarHidden:NO];
////    self.viewDeckController.leftController = [[MenuViewController alloc] init];
//    
//    [[self navigationController] setViewControllers:[NSArray arrayWithObject:nextViewController]  animated:NO];
}

- (void) _goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) _lostPasstword
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mot de passe oublié ?" message:@"Saisis ton adresse email : " delegate:self cancelButtonTitle:@"Annuler" otherButtonTitles:@"Ok",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSDictionary *params = @{@"email":[alertView textFieldAtIndex:0].text};
        [self.userResetService postWithParameters:params forView:self.view];
    }
}


#pragma mark Login 
-(BOOL) _isLoginFormValid
{
    NSString *email = [self loginView].emailTextField.text;
    NSString *password = [self loginView].passwordTextField.text;
    
    return email && password && [email length] > 0 && [password length] > 0;
}

-(void) _sendLoginRequest
{
    
    if ([self _isLoginFormValid])
    {
         NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                [self loginView].emailTextField.text, @"email",
                                [self loginView].passwordTextField.text, @"passwd",
                                nil];
        
        
        [self.loginService postWithParameters:params forView:self.view];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Désolé !"
                                                        message:@"Tu dois indiquer un email et un mot de passe pour te connecter."
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }

}

-(void) _doLogin
{
    TvViewController *nextViewController = [[TvViewController alloc] init];
    
    CATransition* transition = [CATransition animation];
    transition.duration = 0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    
    [self.navigationController setNavigationBarHidden:NO];
    self.viewDeckController.leftController = [[MenuViewController alloc] init];
    
    [[self navigationController] setViewControllers:[NSArray arrayWithObject:nextViewController]  animated:NO];
}

#pragma mark Facebook Login
-(void) _connectToFacebook
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSLog(@"_connectToFacebook");
    
    
    if (!FBSession.activeSession.isOpen)
    {
        NSLog(@"Session not active");
        [FBSession openActiveSessionWithReadPermissions:@[@"email"]
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
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
            [self _printError:@"Facebook FBSessionStateClosed : FBSessionStateClosedLoginFailed" error:error];
            
        }
            break;
        case FBSessionStateClosedLoginFailed:
        {
            NSLog(@"Facebook _sessionStateChanged : FBSessionStateClosedLoginFailed");
            [FBSession.activeSession closeAndClearTokenInformation];
            [self _printError:@"Facebook FBSessionStateClosedLoginFailed : FBSessionStateClosedLoginFailed" error:error];
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
        displayMessage = @"tu n'es pas connecté à facebook";
    }
    
    if(error.code == 2)
    {
        displayMessage = @"tu dois autoriser HobbyOut à se connecter à ton compte facebook";
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

- (void) loginFail:(LoginService*)loginService message:(NSString *)message
{
    NSString *show;
    
    if (message)
        show = message;
    else
        show = @"L'email et/ou le mot de passe indiqués ne sont pas corrects.";
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Désolé !"
                                                    message:show
                                                   delegate:self
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
    
    [self loginView].passwordTextField.text = @"";
}

#pragma mark TextField
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.loginView.emailTextField)
    {
        [self.loginView.passwordTextField becomeFirstResponder];
    }
    else
    {
        [textField resignFirstResponder];
        [self _sendLoginRequest];
    }
    
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}


@end
