//
//  WelcomeView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "WelcomeView.h"

@implementation WelcomeView

- (id)init
{
    self = [super initWithFrame:[UIScreen mainScreen].applicationFrame];
    if (self) {
        
       
       [self setBackgroundImage:@"login-background.jpg"];
               
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 301, 341)];
        [self addSubview:self.scrollView toTop:@30 right:nil bottom:nil left:@10];
        
        self.scrollView.clipsToBounds = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        
        for (int i = 1; i <= 4; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"welcomeSlide%i", i]]];
            imageView.frame = CGRectMake((i - 1) * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width,
                                         self.scrollView.frame.size.height);
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [self.scrollView addSubview:imageView];
        }
        
        [self.scrollView  setContentSize:CGSizeMake(self.scrollView.frame.size.width * 4, self.scrollView.frame.size.height)];
        
        self.pageControl = [[StyledPageControl alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        self.pageControl.numberOfPages = 4;
        self.pageControl.currentPage = 0;
        [self.pageControl setCoreNormalColor:[UIColor whiteColor]];
        [self.pageControl setCoreSelectedColor:[UIColor darkGrayColor]];
        
        [self addSubview:self.pageControl toTop:@360 right:nil bottom:nil left:@110];
        
        self.connectButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 133, 44)];
        [self.connectButton setImage:[UIImage imageNamed:@"welcomeConnectButton"] forState:UIControlStateNormal];
        self.connectButton.alpha = 0;
        [self addSubview:self.connectButton];
        [self addSubview:self.connectButton toTop:nil right:nil bottom:@20 left:@20];
        
        self.visitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 130, 44)];
        [self.visitButton setImage:[UIImage imageNamed:@"welcomeGuestButton"] forState:UIControlStateNormal];
        self.visitButton.alpha = 0;
        [self addSubview:self.visitButton toTop:nil right:@20 bottom:@20 left:nil];
    }
    return self;
}

@end
