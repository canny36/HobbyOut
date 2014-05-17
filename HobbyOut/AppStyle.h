//
//  AppStyle.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbsctractLayoutView.h"


@interface AppStyle : NSObject

+ (void) navigationBar:(UINavigationBar *)navigationBar;

+ (UIColor *) backgroundColor;

+ (void) loginForm:(AbsctractLayoutView *) form;
+ (void) loginText:(UILabel *) label;
+ (void) lostPasswordLadbel:(UILabel *) label;

+ (void) headerText:(UILabel *) label;

+ (void) eventWhiteLabel:(UILabel *) label;
+ (void) eventGreyLabel:(UILabel *) label;
+ (void) eventNameLabel:(UILabel *) label;
+ (void) eventStatusLabel:(UILabel *) label;

+ (void) menuTitleLabel:(UILabel *) label;
+ (void) menuItemLabel:(UILabel *) label;

+(void) textField:(UITextField *)textField;

+ (void) meetingEventNameLabel:(UILabel *) label;
+ (void) meetingDateLabel:(UILabel *) label;
+ (void) meetingNameLabel:(UILabel *) label;
+ (void) meetingDistanceLabel:(UILabel *) label;
+ (void) meetingAdressLabel:(UILabel *) label;
+ (void) meetingStatusLabel:(UILabel *) label;
+ (void) meetingDetailsNameLabel:(UILabel *) label;
+ (void) meetingNbParticipantLabel:(UILabel *) label;
+ (void) meetingPlaceFreeLabel:(UILabel *) label;

+ (void) memberDescLabel:(UILabel *) label;
+ (void) memberBadgeLabel:(UILabel *) label;
+ (void) memberPointsLabel:(UILabel *) label;
+ (void) memberCat1Label:(UILabel *) label;

+(void) sportNameLabel:(UILabel *) label;


+ (void) popUpTitleLabel:(UILabel *) label;

+ (void) tribuneTvNumverLabel:(UILabel *) label;
+ (void) tribuneTypeLabel:(UILabel *) label;

+ (void) participantNameLabel:(UILabel *) label;
+ (void) particpantPhotoFrame:(UIImageView *) photoFrame;
+ (void) cancelPhotoFrame:(UIImageView *) photoFrame;

+(void) friendRequest:(UILabel *) label;
+ (void) requestEventName:(UILabel *) label;




@end
