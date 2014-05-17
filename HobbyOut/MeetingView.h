//
//  MeetingView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 28/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIVView.h"

@interface MeetingView : UIVView

@property (nonatomic) UILabel *dateLabel;
@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UILabel *categoryLabel;
@property (nonatomic) UIImageView *broadcasterImageView;




@property (nonatomic)  UITableView *meetingTableView;



@end
