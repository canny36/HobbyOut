//
//  WelcomeView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAbsolutView.h"
#import "StyledPageControl.h"

@interface WelcomeView : UIAbsolutView

@property(nonatomic) UIScrollView *scrollView;
@property(nonatomic) StyledPageControl *pageControl;

@property(nonatomic) UIButton *connectButton;
@property(nonatomic) UIButton *visitButton;

@end
