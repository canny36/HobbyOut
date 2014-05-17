//
//  MeetingDetailsView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAbsolutView.h"
#import "ParticipantPopUpView.h"

@interface MeetingDetailsView : UIAbsolutView

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *eventNameLabel;
@property (nonatomic) UILabel *categoryLabel;

@property (nonatomic) UILabel *placeNameLabel;
@property (nonatomic) UILabel *adressLabel;
@property (nonatomic) UILabel *cityLabel;
@property (nonatomic) UILabel *distanceLabel;
@property (nonatomic) UILabel *nbParticipantLabel;
@property (nonatomic) UILabel *statusLabel;

@property(nonatomic) UIButton *participateButton;
@property(nonatomic) UIButton *inviteFriends;
@property(nonatomic) UIButton *mapButton;

@property (nonatomic) UIImageView *placeHeader;

@property (nonatomic) UIImageView *participant1;
@property (nonatomic) UIImageView *participant2;
@property (nonatomic) UIImageView *participant3;
@property (nonatomic) UIImageView *participant4;
@property (nonatomic) UIImageView *participant5;
@property (nonatomic) UIImageView *participant6;
@property (nonatomic) UIImageView *participantMore;

@property (nonatomic) UILabel *nbPlace;

@property (nonatomic) UILabel *moreNumberLabel;

@property (nonatomic) UIView *touchParticipantView;

@property (nonatomic) ParticipantPopUpView *participantPopUp;

@end
