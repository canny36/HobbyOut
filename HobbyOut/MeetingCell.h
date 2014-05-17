//
//  MeetingCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 28/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"

@interface MeetingCell : UITableViewCell

@property(nonatomic) Meeting *meeting;

@property(nonatomic) UILabel *nameLabel;
@property(nonatomic) UILabel *distanceLabel;
@property(nonatomic) UILabel *adresseLabel;
@property(nonatomic) UILabel *cityLabel;
@property(nonatomic) UILabel *statusLabel;

@property(nonatomic) UIImageView *header;;


@property(nonatomic) UIButton *participateButton;
@property(nonatomic) UIButton *mapButton;

-(void) displayMeeting:(Meeting *) metting;
-(void) refresh;


@end
