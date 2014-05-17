//
//  LoginViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginService.h"
#import "LoginFacebookService.h"

#import "UserResetService.h"
#import "TrackedViewController.h"

@interface LoginViewController : TrackedViewController

@property(nonatomic) LoginService *loginService;
@property(nonatomic) LoginFacebookService *loginFacebookService;

@property(nonatomic) UserResetService *userResetService;

@end
