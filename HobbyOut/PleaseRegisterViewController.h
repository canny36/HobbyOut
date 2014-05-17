//
//  PleaseRegisterViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginFacebookService.h"

#import "TrackedViewController.h"

@interface PleaseRegisterViewController : TrackedViewController

@property(nonatomic) LoginFacebookService *loginFacebookService;

@end
