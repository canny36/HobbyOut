//
//  MeetingDetailsView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MeetingDetailsView.h"
#import "AppStyle.h"

@implementation MeetingDetailsView

- (id)init{
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height - 48)];
    if (self)
    {
        [self setBackgroundColor:[AppStyle backgroundColor]];
        [self setBackgroundImage:@"meetingDetails.png"];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        [AppStyle meetingDateLabel:self.dateLabel];
        [self addSubview:self.dateLabel toTop:@5 right:@80 bottom:nil left:@80];
        
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        [AppStyle eventGreyLabel:self.categoryLabel];
        self.categoryLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.categoryLabel toTop:@40 right:@100 bottom:nil left:@118];
        
        self.eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 55)];
        [AppStyle meetingEventNameLabel:self.eventNameLabel];
        [self addSubview:self.eventNameLabel toTop:@58 right:@10 bottom:nil left:@10];
        
        self.placeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingDetailsNameLabel:self.placeNameLabel];
        [self addSubview:self.placeNameLabel toTop:@120 right:@10 bottom:nil left:@10];
        self.placeNameLabel.userInteractionEnabled = YES;
        
        self.placeHeader = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 299, 59)];
        self.placeHeader.contentMode = UIViewContentModeScaleToFill;
        self.placeHeader.clipsToBounds = YES;
        [self addSubview:self.placeHeader toTop:@146 right:@10 bottom:nil left:nil];
        self.placeHeader.userInteractionEnabled = YES;
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingDistanceLabel:self.distanceLabel];
        [self addSubview:self.distanceLabel toTop:@225 right:@10 bottom:nil left:@23];

        
        self.adressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingAdressLabel:self.adressLabel];
        [self addSubview:self.adressLabel toTop:@210 right:@10 bottom:nil left:@85];
        
        self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingAdressLabel:self.cityLabel];
        [self addSubview:self.cityLabel toTop:@225 right:@10 bottom:nil left:@85];
        
        self.mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 34)];
        [self.mapButton setImage:[UIImage imageNamed:@"geolocButton.png"] forState:UIControlStateNormal];
        [self addSubview:self.mapButton toTop:@191 right:nil bottom:nil left:@268];
        
        self.participateButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 53)];
        [self.participateButton setImage:[UIImage imageNamed:@"meetingDetailsParticipateButton.png"] forState:UIControlStateNormal];
         [self addSubview:self.participateButton toTop:nil right:@10 bottom:@0 left:@10];
        
        self.inviteFriends = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,100, 53)];
        self.inviteFriends.hidden = YES;
        self.inviteFriends.titleLabel.text = @"Invite Friends";
         [self addSubview:self.inviteFriends toTop:nil right:@10 bottom:@0 left:@10];
//        [self.participateButton setImage:[UIImage imageNamed:@"meetingDetailsParticipateButton.png"] forState:UIControlStateNormal];
       
        
        self.nbPlace = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingPlaceFreeLabel:self.nbPlace];
        [self addSubview:self.nbPlace toTop:nil right:@10 bottom:@28 left:@10];
        
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 53)];
        [AppStyle meetingStatusLabel:self.statusLabel];
        [self addSubview:self.statusLabel toTop:nil right:@10 bottom:@0 left:@10];
        
        
        
        self.touchParticipantView = [[UIView alloc] initWithFrame:CGRectMake(10, 265, 300, 80)];
        self.touchParticipantView.userInteractionEnabled = YES;
        [self addSubview:self.touchParticipantView];
        
        self.nbParticipantLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingNbParticipantLabel:self.nbParticipantLabel];
        [self addSubview:self.nbParticipantLabel toTop:@265 right:@23 bottom:nil left:@23];
        
        self.participant1 = [[UIImageView alloc] initWithFrame:CGRectMake(23, 302, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant1];
        [self addSubview:self.participant1];
        
        self.participant2 = [[UIImageView alloc] initWithFrame:CGRectMake(63, 302, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant2];
        [self addSubview:self.participant2];
        
        self.participant3 = [[UIImageView alloc] initWithFrame:CGRectMake(103, 302, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant3];
        [self addSubview:self.participant3];
        
        self.participant4 = [[UIImageView alloc] initWithFrame:CGRectMake(143, 302, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant4];
        [self addSubview:self.participant4];
        
        self.participant5 = [[UIImageView alloc] initWithFrame:CGRectMake(183, 302, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant5];
        [self addSubview:self.participant5];
        
        self.participant6 = [[UIImageView alloc] initWithFrame:CGRectMake(223, 302, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant6];
        [self addSubview:self.participant6];
        
        self.participantMore = [[UIImageView alloc] initWithFrame:CGRectMake(263, 302, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participantMore];
        [self addSubview:self.participantMore];
        
        self.moreNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(263, 302, 35, 35)];
        [AppStyle eventGreyLabel:self.moreNumberLabel];
        self.moreNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.moreNumberLabel];

        
        self.participantPopUp = [[ParticipantPopUpView alloc] init];
        self.participantPopUp.hidden = YES;
        [self addSubview:self.participantPopUp toTop:@5 right:@3 bottom:nil left:nil];
        

        
        
        
    }
    
    return self;
}

@end
