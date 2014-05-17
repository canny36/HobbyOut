//
//  WelcomeViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WelcomeView.h"
#import "LoginViewController.h"
#import "UserDefaultManager.h"
#import "TvViewController.h"
#import "MenuViewController.h"
#import "IIViewDeckController.h"
#import <QuartzCore/QuartzCore.h>

@interface WelcomeViewController ()<UIScrollViewDelegate>

@end

@implementation WelcomeViewController


#pragma mark Manage View
- (void) loadView
{
    self.view = [[WelcomeView alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.navigationController setNavigationBarHidden:YES];
    self.welcomeView.scrollView.delegate = self;
    
    
    if ([UserDefaultManager getSessionToken])
    {
        [self _doLogin];
    }
    else
    {
        [UIView animateWithDuration:0.5 animations:^{
            self.welcomeView.connectButton.alpha = 1;
            self.welcomeView.visitButton.alpha = 1;
        }];
    
        [self.welcomeView.connectButton addTarget:self action:@selector(_connect) forControlEvents:UIControlEventTouchUpInside];
        [self.welcomeView.visitButton addTarget:self action:@selector(_doLogin) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (WelcomeView *) welcomeView
{
    return (WelcomeView *)self.view;
}

#pragma mark Action

- (void) _connect
{
    [self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
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

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = 301;
    float fractionalPage = self.welcomeView.scrollView.contentOffset.x / pageWidth;
    NSInteger page = lround(fractionalPage);
    self.welcomeView.pageControl.currentPage = page;
}

@end
