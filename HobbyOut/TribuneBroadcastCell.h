//
//  TribuneBroadcastCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 26/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TvBroadcast.h"

@interface TribuneBroadcastCell : UITableViewCell

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *competitionLabel;
@property (nonatomic) UILabel *distanceLabel;
@property (nonatomic) UILabel *eventNameLabel;

@property (nonatomic) UIImageView *broadcasterImageView;

-(void) displayTvBroadcast:(TvBroadcast *) tvBroadcast;

@end
