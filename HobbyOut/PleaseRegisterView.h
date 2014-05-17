//
//  PleaseRegisterView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIVView.h"
#import "StyledPageControl.h"

@interface PleaseRegisterView : UIVView

@property(nonatomic) UIScrollView *scrollView;
@property(nonatomic) StyledPageControl *pageControl;
@property(nonatomic) UIButton *facebookConnectButton;
@property(nonatomic) UIButton *registerButton;


@end
