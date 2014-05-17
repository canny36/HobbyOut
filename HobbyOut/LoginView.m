//
//  LoginView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "LoginView.h"
#import "UIHView.h"
#import  "AppStyle.h"

#import "UIColor+category.h"

@implementation LoginView

- (id)init{
    
    self = [super initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    if (self) {
        [self setBackgroundImage:@"login-background.jpg"];
        self.hAlign = center;
        self.vAlign = top;
        self.gap = 2;
        
        
        UIHView *header = [[UIHView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 70)];
        header.padding = 5;
        header.vAlign = top;
        [self layoutSubview:header];
        
        self.backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        [self.backButton  setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [header layoutSubview:self.backButton];
        
        UIImageView *logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo-white.png"]];
        [self layoutSubview:logo];
    
        [self layoutSubview:[[UIView alloc]init]  withSize:CGSizeMake(250, 10)];
        
        UIVView *formView = [[UIVView alloc] init];
        [AppStyle loginForm:formView];
        [self layoutSubview:formView withSize:CGSizeMake(260, 90)];
        
        self.emailTextField = [[UITextField alloc] init];
        _emailTextField.placeholder = @"Email";
        _emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        _emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _emailTextField.returnKeyType = UIReturnKeyNext;
        [AppStyle textField:_emailTextField];
        [formView layoutSubview:self.emailTextField  withSize:CGSizeMake(250, 40)];
        
        UIView *separator = [[UIView alloc] init];
        separator.backgroundColor = [UIColor colorWithHexString:@"f0a07b"];
        [formView layoutSubview:separator withSize:CGSizeMake(250, 1)];
        
        self.passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"Mot de passe";
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        [AppStyle textField:_passwordTextField];
        [formView layoutSubview:self.passwordTextField  withSize:CGSizeMake(250, 40)];
        
        self.lostPassword = [[UILabel alloc] init];

        NSString *lostPasswordString = @"MOT DE PASSE OUBLIÉ ?";
        NSRange range = [lostPasswordString rangeOfString:@"MOT DE PASSE OUBLIÉ"];
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @1};
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lostPasswordString];
        [attributedString setAttributes:underlineAttribute range:range];
        
        self.lostPassword.attributedText = attributedString;

        
        
        [AppStyle lostPasswordLadbel:self.lostPassword];
        [self layoutSubview:self.lostPassword  withSize:CGSizeMake(250, 20)];
        
        
        
        [self layoutSubview:[[UIView alloc]init]  withSize:CGSizeMake(250, 20)];
        
        self.connectionButton = [[UIButton alloc] init];
        [self.connectionButton setImage:[UIImage imageNamed:@"login-confirm-button.png"] forState:UIControlStateNormal];
        [self layoutSubview:_connectionButton withSize:CGSizeMake(265, 44)];
        
        [self layoutSubview:[[UIView alloc]init]  withSize:CGSizeMake(250, 7)];
        
        
        UILabel *orLabel = [[UILabel alloc] init];
        orLabel.text = @"OU";
        [AppStyle loginText:orLabel];
        [self layoutSubview:orLabel withSize:CGSizeMake(25, 25)];
        
        [self layoutSubview:[[UIView alloc]init]  withSize:CGSizeMake(250, 7)];
        
        
        self.facebookConntectionButton = [[UIButton alloc] init];
        [self.facebookConntectionButton setImage:[UIImage imageNamed:@"login-facebook-button.png"] forState:UIControlStateNormal];
        [self layoutSubview:_facebookConntectionButton withSize:CGSizeMake(275, 53)];
        
        self.registerButton = [[UIButton alloc] init];
        [self.registerButton setImage:[UIImage imageNamed:@"registerButton.png"] forState:UIControlStateNormal];
        [self layoutSubview:self.registerButton withSize:CGSizeMake(275, 53)];

        
        
        
    }
    return self;
}


@end
