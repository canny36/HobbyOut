//
//  TribuneDetailsView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 24/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAbsolutView.h"

@interface TribuneDetailsView : UIAbsolutView

@property(nonatomic) UITableView *tableView;
@property(nonatomic) UILabel *distanceLabel;
@property(nonatomic) UILabel *barCategoryLabel;
@property(nonatomic) UILabel *addressLabel;
@property(nonatomic) UILabel *address2Label;
@property(nonatomic) UILabel *equipmentLabel;

@property(nonatomic) UIImageView *avatarView;
@property(nonatomic) UIButton *eventsButton;
@property(nonatomic) UIButton *broadcastsButton;

@property(nonatomic) UIImageView *tribuneTypeImageView;
@property(nonatomic) UIImageView *tribuneHeaderImageView;

@property(nonatomic) UIButton *mapButton;

@end
