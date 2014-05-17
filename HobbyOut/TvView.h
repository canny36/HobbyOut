//
//  TvView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIVView.h"
#import "UIAbsolutView.h"

@interface TvView : UIVView

@property (nonatomic) UITableView *tvTableView;
@property (nonatomic) UIButton *calendarButton;
@property (nonatomic) UILabel *dateLabel;

@property (nonatomic) UIAbsolutView *noDataFrame;
@property (nonatomic) UIButton *searchButton;

@end
