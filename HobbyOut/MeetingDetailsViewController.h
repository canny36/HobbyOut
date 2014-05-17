//
//  MeetingDetailsViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"
#import "ParticipateService.h"
#import "ParticipantPopUpViewController.h"
#import "TrackedViewController.h"

@interface MeetingDetailsViewController : TrackedViewController

@property(nonatomic) Meeting *meeting;
@property(nonatomic) ParticipateService *participateService;
@property(nonatomic) ParticipantPopUpViewController *popUpController;

-(id) initWithMeeting:(Meeting *) meeting;

@end
