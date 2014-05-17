//
//  EventCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"

@interface EventCell : UITableViewCell

@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *competitionLabel;
@property (nonatomic) UILabel *distanceLabel;
@property (nonatomic) UILabel *eventNameLabel;

@property (nonatomic) UIImageView *sportIconImageView;

-(void) displayEvent:(Meeting *)meeting;

@end
