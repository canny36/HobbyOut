//
//  AppDelegate.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
#import "GAI.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController* navigationController;
@property (nonatomic, strong) id<GAITracker> tracker;

@end
