//
//  SearchEventCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 18/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Meeting.h"

@interface SearchEventCell : UITableViewCell

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *competitionLabel;
@property (nonatomic) UILabel *distanceLabel;
@property (nonatomic) UILabel *eventNameLabel;

@property (nonatomic) UIImageView *broadcasterImageView;
@property (nonatomic) UIImageView *participant1;
@property (nonatomic) UIImageView *participant2;
@property (nonatomic) UIImageView *participant3;
@property (nonatomic) UIImageView *participant4;
@property (nonatomic) UIImageView *participant5;
@property (nonatomic) UIImageView *participant6;
@property (nonatomic) UIImageView *participantMore;

@property (nonatomic) UILabel *moreNumberLabel;


-(void) displayEvent:(Meeting *) meeting;

@end

