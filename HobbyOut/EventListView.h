//
//  EventListView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIVView.h"
#import "UIAbsolutView.h"

@interface EventListView : UIVView

@property (nonatomic) UITableView *eventTableView;
@property (nonatomic) UIButton *calendarButton;
@property (nonatomic) UILabel *dateLabel;

@property (nonatomic) UIAbsolutView *noDataFrame;
@property (nonatomic) UIButton *searchButton;

@end
