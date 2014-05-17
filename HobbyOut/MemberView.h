//
//  MemberView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 05/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAbsolutView.h"

@interface MemberView : UIAbsolutView

@property(nonatomic) UIImageView *avatarView;
@property(nonatomic) UILabel *descLabel;
@property(nonatomic) UILabel *badgeLabel;
@property(nonatomic) UILabel *pointLabel;
@property(nonatomic) UITableView *sportsTableView;
@property(nonatomic) UITableView *eventsTableView;
@property(nonatomic) UIButton *editButton;
@property(nonatomic) UIButton *okButton;
@property(nonatomic) UIButton *cancelButton;
@property(nonatomic) UIButton *addButton;

@end
