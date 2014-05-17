//
//  MeetingViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 28/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TvBroadcast.h"
#import "ParticipateService.h"

#import "TrackedViewController.h"

@interface MeetingViewController : TrackedViewController

@property (nonatomic) TvBroadcast *tvBroadcast;
@property (nonatomic) ParticipateService *participateService;

-(id) initWithTvBroadcast:(TvBroadcast *) tvBroadcast;

@end
