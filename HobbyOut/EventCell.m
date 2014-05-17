//
//  EventCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "EventCell.h"
#import "AppStyle.h"


@implementation EventCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eventRenderer"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"eventRenderer"]];
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 27, 50, 20)];
        [AppStyle eventWhiteLabel:self.timeLabel];
        [self addSubview:self.timeLabel];
        
        self.competitionLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 28, 150, 20)];
        [AppStyle eventGreyLabel:self.competitionLabel];
        [self addSubview:self.competitionLabel];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(245, 28, 100, 20)];
        [AppStyle meetingDistanceLabel:self.distanceLabel];
        [self addSubview:self.distanceLabel];
    
        self.eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 48, 260, 60)];
        [AppStyle eventNameLabel:self.eventNameLabel];
        [self addSubview:self.eventNameLabel];
        
        self.sportIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 15, 27, 27)];
        [self addSubview:self.sportIconImageView];
        
    }
    return self;
}

-(void) displayEvent:(Meeting *)meeting
{
    self.timeLabel.text = meeting.hour;
    self.competitionLabel.text = meeting.category;
    self.distanceLabel.text = meeting.distanceString;
    self.eventNameLabel.text = meeting.eventName;
    self.sportIconImageView.image = meeting.icone;
}

@end
