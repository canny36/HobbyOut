//
//  AppStyle.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AppStyle.h"
#import "UIColor+category.h"

#import <QuartzCore/QuartzCore.h>
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@implementation AppStyle



+(void) textField:(UITextField *)textField
{
    textField.clipsToBounds = YES;
    textField.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
}

+ (UIColor *) backgroundColor
{
    return [UIColor colorWithHexString:@"eeedeb"];
}

+(void) loginForm:(AbsctractLayoutView *) form
{
    form.gap = 0;
    form.padding = 5;
    form.hAlign = middle;
    form.backgroundColor = [UIColor whiteColor];
    form.layer.cornerRadius = 5;
}


+ (void) loginText:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Condensed" size:16];
    label.textColor = [UIColor whiteColor];
}

+ (void) lostPasswordLadbel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:14];
    label.textColor = [UIColor whiteColor];
}

+ (void) headerText:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Oswald" size:16];
    label.textColor = [UIColor colorWithHexString:@"3c3c3c"];
}


+ (void) eventWhiteLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:12];
    label.textColor = [UIColor whiteColor];
}

+ (void) eventGreyLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:12];
    label.textColor = [UIColor colorWithHexString:@"afa79f"];
}



+ (void) eventNameLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:15];
    label.textColor = [UIColor colorWithHexString:@"3c3c3c"];
}

+ (void) eventStatusLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:13];
    label.textColor = [UIColor colorWithHexString:@"c2c0b8"];
}

+ (void) menuTitleLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:18];
    label.textColor = [UIColor colorWithHexString:@"898888"];
}

+ (void) menuItemLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:16];
    label.textColor = [UIColor whiteColor];
}

+ (void) meetingDateLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Oswald" size:15];
    label.textColor = [UIColor colorWithHexString:@"565551"];
    label.adjustsFontSizeToFitWidth = TRUE;
}

+ (void) meetingEventNameLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:20];
    label.textColor = [UIColor colorWithHexString:@"3c3c3c"];
    label.adjustsFontSizeToFitWidth = TRUE;
}

+ (void) meetingNameLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:18];
    label.textColor = [UIColor whiteColor];
}


+ (void) meetingDistanceLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:11];
    label.textColor = [UIColor colorWithHexString:@"ff682a"];
}

+ (void) meetingAdressLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    label.textColor = [UIColor colorWithHexString:@"89827b"];
}

+ (void) meetingStatusLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:14];
    label.textColor = [UIColor colorWithHexString:@"ff682a"];
}


+ (void) meetingDetailsNameLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:18];
    label.textColor = [UIColor colorWithHexString:@"3c3c3c"];
}


+ (void) meetingNbParticipantLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:18];
    label.textColor = [UIColor colorWithHexString:@"ff682a"];
}

+ (void) meetingPlaceFreeLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    label.textColor = [UIColor whiteColor];
}


+ (void) memberDescLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:16];
    label.textColor = [UIColor colorWithHexString:@"afa79f"];
}


+ (void) memberBadgeLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:16];
    label.textColor = [UIColor colorWithHexString:@"ff682a"];
}

+ (void) memberPointsLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:14];
    label.textColor = [UIColor colorWithHexString:@"afa79f"];
}

+ (void) memberCat1Label:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [AppStyle backgroundColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:12];
    label.textColor = [UIColor colorWithHexString:@"3c3c3c"];
}

+(void) sportNameLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:12];
    label.textColor = [UIColor colorWithHexString:@"ff682a"];
}

+ (void) popUpTitleLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
    label.textColor = [UIColor colorWithHexString:@"464646"];
}


+ (void) participantNameLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Regular" size:12];
    label.textColor = [UIColor colorWithHexString:@"444444"];
    label.adjustsFontSizeToFitWidth = YES;
}

+(void) particpantPhotoFrame:(UIImageView *) photoFrame
{
    photoFrame.backgroundColor = [UIColor colorWithHexString:@"eeedeb"];
    photoFrame.layer.cornerRadius = 5;
    photoFrame.clipsToBounds = YES;
    [photoFrame.layer setBorderColor: [[UIColor colorWithHexString:@"e2e1dd"] CGColor]];
    [photoFrame.layer setBorderWidth: 2.0];
}



+(void) cancelPhotoFrame:(UIImageView *) photoFrame
{
    photoFrame.backgroundColor = [UIColor clearColor];
    photoFrame.layer.cornerRadius = 0;
    photoFrame.clipsToBounds = YES;
    [photoFrame.layer setBorderColor: [[UIColor clearColor] CGColor]];
    [photoFrame.layer setBorderWidth: 0];
}


+ (void) tribuneTypeLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:16];
    label.textColor = [UIColor whiteColor];
    label.adjustsFontSizeToFitWidth = YES;
}

+ (void) tribuneTvNumverLabel:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:14];
    label.textColor = [UIColor colorWithHexString:@"5f5a54"];
    label.adjustsFontSizeToFitWidth = YES;
}

+(void) friendRequest:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByClipping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:12];
    label.textColor = [UIColor colorWithHexString:@"1c1c10"];
    label.adjustsFontSizeToFitWidth = YES;
}


+ (void) requestEventName:(UILabel *) label
{
    label.textAlignment = NSTextAlignmentCenter;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Roboto-Medium" size:18];
    label.textColor = [UIColor colorWithHexString:@"ff682a"];
}


+ (void) navigationBar:(UINavigationBar *)navigationBar
{

    if (IS_OS_7_OR_LATER) {
        [navigationBar setBackgroundImage:[UIImage imageNamed: @"header_64.png"]
                            forBarMetrics:UIBarMetricsDefault];
    }else{
        [navigationBar setBackgroundImage:[UIImage imageNamed: @"navigationBarBackground.png"]
                            forBarMetrics:UIBarMetricsDefault];
    }
    

    [navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      UITextAttributeTextColor,
      [UIFont fontWithName:@"Roboto-Medium" size:18],
      UITextAttributeFont,
      nil]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                                                  [UIColor orangeColor],
                                                                                                  UITextAttributeTextColor,
                                                                                                  [UIColor clearColor],
                                                                                                  UITextAttributeTextShadowColor,
                                                                                                  [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
                                                                                                  UITextAttributeTextShadowOffset,
                                                                                                  nil] 
                                                                                        forState:UIControlStateNormal];
    
    [navigationBar setTitleVerticalPositionAdjustment:2 forBarMetrics:UIBarMetricsDefault];
}

@end
