//
//  TribuneBroadcastCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 26/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TribuneBroadcastCell.h"
#import "AppStyle.h"

#import "UIImageView+WebCache.h"

@implementation TribuneBroadcastCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"memberBroadcast.png"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"memberBroadcast.png"]];
        
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
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(240, 28, 50, 20)];
        [AppStyle eventGreyLabel:self.distanceLabel];
        [self addSubview:self.distanceLabel];
        
        self.eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 53, 280, 80)];
        [AppStyle eventNameLabel:self.eventNameLabel];
        [self addSubview:self.eventNameLabel];
        
        self.broadcasterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(255, 15, 35, 26)];
        self.broadcasterImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.broadcasterImageView];
        
    }
    return self;
}

-(void) displayTvBroadcast:(TvBroadcast *) tvBroadcast
{
    self.competitionLabel.text = tvBroadcast.category;
    self.timeLabel.text = tvBroadcast.hour;
    self.eventNameLabel.text = tvBroadcast.name;
    self.dateLabel.text = tvBroadcast.fullWithDayDate;
    [self.broadcasterImageView setImageWithURL:[NSURL URLWithString:tvBroadcast.broadcasterPath]];
}

@end
