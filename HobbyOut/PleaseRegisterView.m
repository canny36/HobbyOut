//
//  PleaseRegisterView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "PleaseRegisterView.h"
#import "AppStyle.h"

@implementation PleaseRegisterView

- (id)init
{
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height - 48)];
    
    if (self) {
        [self setBackgroundColor:[AppStyle backgroundColor]];
        
        self.padding = 8;
        self.gap = 3;
        self.hAlign = center;
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.clipsToBounds = YES;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        
        for (int i = 1; i <= 3; i++)
        {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"registerSlide%i", i]]];
            imageView.frame = CGRectMake((i - 1) * 302, 0, 302, 236);
            [self.scrollView addSubview:imageView];
        }

        [self.scrollView  setContentSize:CGSizeMake(302 * 3, 236)];
        
        [self layoutSubview:self.scrollView withSize:CGSizeMake(302, 236)];
        
        self.pageControl = [[StyledPageControl alloc]init];
        self.pageControl.numberOfPages = 3;
        self.pageControl.currentPage = 0;
        [self.pageControl setCoreNormalColor:[UIColor lightGrayColor]];
        [self.pageControl setCoreSelectedColor:[UIColor orangeColor]];

        [self layoutSubview:self.pageControl withSize:CGSizeMake(100, 20)];
        
        [self layoutSubview:[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"registerNotice"]]];
        
        self.facebookConnectButton = [[UIButton alloc]init];
        [self.facebookConnectButton setImage:[UIImage imageNamed:@"registerFacebookButton"] forState:UIControlStateNormal];
        [self layoutSubview:self.facebookConnectButton withSize:CGSizeMake(270, 42)];
        
        self.registerButton = [[UIButton alloc]init];
        [self.registerButton setImage:[UIImage imageNamed:@"registerButton"] forState:UIControlStateNormal];
        [self layoutSubview:self.registerButton withSize:CGSizeMake(270, 42)];
        


    }
    return self;
}



@end
