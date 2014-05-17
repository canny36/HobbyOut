//
//  AppDelegate.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AppDelegate.h"
#import "WelcomeViewController.h"
#import "IIViewDeckController.h"
#import "PushService.h"


#import "AppStyle.h"

#import <FacebookSDK/FacebookSDK.h>
#import "GAI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [FBSession.activeSession handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *centerController = [[UINavigationController alloc] initWithRootViewController:[[WelcomeViewController alloc] init]];
    
    [AppStyle navigationBar:centerController.navigationBar];
    
    [centerController setNavigationBarHidden:YES];
    
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
    
    IIViewDeckController* deckController =  [[IIViewDeckController alloc]
                                             initWithCenterViewController:centerController
                                             leftViewController:nil
                                             rightViewController:nil];
    
    self.window.rootViewController = deckController;
    
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    //[[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:@"UA-32935541-2"];
    
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [FBSession.activeSession handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [FBSession.activeSession close];
}

#pragma --mark Push notification delegate

- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    [self sendDeviceToken:[self deviceTokenWithData:deviceToken]];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}

-(NSString *)deviceTokenWithData:(NSData *)data
{
    NSString *deviceToken = [[data description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceToken = [deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    return deviceToken;
}

-(void)sendDeviceToken:(NSString*)deviceToken{
    
    PushService *pushService = [[PushService alloc] initWithDelegate:^(NSDictionary *response) {
        
    }];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:deviceToken forKey:@"ios_token"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"state"];
    
    [pushService postWithParameters:[dict copy]];
    
}
@end
