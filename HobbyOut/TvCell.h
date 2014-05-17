//
//  TvCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TvBroadcast.h"

@interface TvCell : UITableViewCell

@property (nonatomic) UILabel *timeLabel;
@property (nonatomic) UILabel *competitionLabel;
@property (nonatomic) UIImageView *broadcasterImageView;
@property (nonatomic) UILabel *eventNameLabel;

@property (nonatomic) UIImageView *sportIconImageView;
@property (nonatomic) UILabel *statusLabel;

-(void) displayTvBroadcast:(TvBroadcast *) tvBroadcast;


@end
