//
//  MemberEventCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 06/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MemberEventCell.h"
#import "AppStyle.h"

#import "UIImageView+WebCache.h"

#import "Participant.h"

@implementation MemberEventCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"memberMeeting.png"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"memberMeeting.png"]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, 50, 20)];
        [AppStyle eventWhiteLabel:self.timeLabel];
        [self addSubview:self.timeLabel];
        
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, 200, 20)];
        [AppStyle eventGreyLabel:self.dateLabel];
        [self addSubview:self.dateLabel];
        
        
        self.competitionLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 28, 150, 20)];
        [AppStyle eventGreyLabel:self.competitionLabel];
        [self addSubview:self.competitionLabel];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 28, 100, 20)];
        [AppStyle meetingDistanceLabel:self.distanceLabel];
        [self addSubview:self.distanceLabel];
        
        self.eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 53, 280, 50)];
        [AppStyle eventNameLabel:self.eventNameLabel];
        [self addSubview:self.eventNameLabel];
        
        
        self.participant1 = [[UIImageView alloc] initWithFrame:CGRectMake(12, 115, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant1];
        [self addSubview:self.participant1];
        
        self.participant2 = [[UIImageView alloc] initWithFrame:CGRectMake(52, 115, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant2];
        [self addSubview:self.participant2];
        
        self.participant3 = [[UIImageView alloc] initWithFrame:CGRectMake(92, 115, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant3];
        [self addSubview:self.participant3];
        
        self.participant4 = [[UIImageView alloc] initWithFrame:CGRectMake(132, 115, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant4];
        [self addSubview:self.participant4];
        
        self.participant5 = [[UIImageView alloc] initWithFrame:CGRectMake(172, 115, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant5];
        [self addSubview:self.participant5];
        
        self.participant6 = [[UIImageView alloc] initWithFrame:CGRectMake(212, 115, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participant6];
        [self addSubview:self.participant6];
        
        self.participantMore = [[UIImageView alloc] initWithFrame:CGRectMake(252, 115, 35, 35)];
        [AppStyle particpantPhotoFrame:self.participantMore];
        [self addSubview:self.participantMore];
        
        self.moreNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(252, 115, 35, 35)];
        [AppStyle eventGreyLabel:self.moreNumberLabel];
        self.moreNumberLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.moreNumberLabel];
        
    }
    return self;
}

-(void) displayEvent:(Meeting *) meeting
{
    self.participant1.hidden = YES;
    self.participant2.hidden = YES;
    self.participant3.hidden = YES;
    self.participant4.hidden = YES;
    self.participant5.hidden = YES;
    self.participant6.hidden = YES;
    self.participantMore.hidden = YES;
    self.moreNumberLabel.hidden = YES;
    
    
    self.competitionLabel.text = meeting.category;
    self.distanceLabel.text = meeting.distanceString;
    self.timeLabel.text = meeting.hour;
    self.eventNameLabel.text = meeting.eventName;
    self.dateLabel.text = meeting.fullWithDayDate;
    
    if ([meeting.participants count] > 0)
    {
        self.participant1.hidden = NO;
        [self.participant1 setImageWithURL:[NSURL URLWithString:((Participant *)[meeting.participants objectAtIndex:0]).avatarUrl]];
    }
    
    if ([meeting.participants count] > 1)
    {
        self.participant2.hidden = NO;
        [self.participant2 setImageWithURL:[NSURL URLWithString:((Participant *)[meeting.participants objectAtIndex:1]).avatarUrl]];
    }
    
    if ([meeting.participants count] > 2)
    {
        self.participant3.hidden = NO;
        [self.participant3 setImageWithURL:[NSURL URLWithString:((Participant *)[meeting.participants objectAtIndex:2]).avatarUrl]];
    }
    
    if ([meeting.participants count] > 3)
    {
        self.participant4.hidden = NO;
        [self.participant4 setImageWithURL:[NSURL URLWithString:((Participant *)[meeting.participants objectAtIndex:3]).avatarUrl]];;
    }
    
    if ([meeting.participants count] > 4)
    {
        self.participant5.hidden = NO;
        [self.participant5 setImageWithURL:[NSURL URLWithString:((Participant *)[meeting.participants objectAtIndex:4]).avatarUrl]];
    }
    
    if ([meeting.participants count] > 5)
    {
        self.participant6.hidden = NO;
        [self.participant6 setImageWithURL:[NSURL URLWithString:((Participant *)[meeting.participants objectAtIndex:5]).avatarUrl]];
    }
    
    if ([meeting.participants count] == 7)
    {
        self.participantMore.hidden = NO;
        [self.participantMore setImageWithURL:[NSURL URLWithString:((Participant *)[meeting.participants objectAtIndex:6]).avatarUrl]];
    }
    
    if ([meeting.participants count] > 7)
    {
        self.participantMore.hidden = NO;
        self.moreNumberLabel.hidden = NO;
        self.moreNumberLabel.text = [NSString stringWithFormat:@" +%u", ([meeting.participants count] - 6)];
        
    }
    
}

@end
