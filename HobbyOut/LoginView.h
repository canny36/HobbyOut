//
//  LoginView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIVView.h"

@interface LoginView : UIVView;

@property(nonatomic) UITextField *emailTextField;
@property(nonatomic) UITextField *passwordTextField;

@property(nonatomic) UIButton *connectionButton;
@property(nonatomic) UIButton *facebookConntectionButton;
@property(nonatomic) UIButton *backButton;

@property(nonatomic) UILabel *lostPassword;
@property(nonatomic) UIButton *registerButton;

@end
