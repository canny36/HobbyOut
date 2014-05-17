//
//  EventListView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "EventListView.h"
#import "UIColor+category.h"
#import "UIAbsolutView.h"

#import "AppStyle.h"

@implementation EventListView

- (id)init{
    self = [super initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.gap = 0;
    self.padding = 0;
    
    if (self) {
        [self setBackgroundColor:[AppStyle backgroundColor]];
        
        UIAbsolutView *headerView = [[UIAbsolutView alloc] init];
        [self layoutSubview:headerView withSize:CGSizeMake(320, 48)];
        
        self.dateLabel = [[UILabel alloc] init];
         self.dateLabel.text = @"AUJOURD'HUI";
        [AppStyle headerText: self.dateLabel];
        [headerView addSubview: self.dateLabel toTop:@0 right:@50 bottom:@-3 left:@5];
        
        self.calendarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 34)];
        [self.calendarButton setImage:[UIImage imageNamed:@"planningButton.png"]
                             forState:UIControlStateNormal];
        [headerView addSubview:self.calendarButton toTop:@10 right:@5 bottom:nil left:nil];
        
        self.eventTableView = [[UITableView alloc] init];
        self.eventTableView.rowHeight = 125;
        self.eventTableView.sectionHeaderHeight = 61;
        self.eventTableView.backgroundColor = [UIColor clearColor];
        self.eventTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self layoutSubview:self.eventTableView withSize:CGSizeMake(320,
                                                        self.frame.size.height - headerView.frame.size.height - 48)];
        
        self.noDataFrame = [[UIAbsolutView alloc] initWithFrame:CGRectMake(0, 70, 320, 215)];
        [self.noDataFrame setBackgroundImage:@"noResultPanel.png"];
        self.noDataFrame.hidden = YES;
        [self addSubview:self.noDataFrame];
        
        
        self.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 267, 49)];
        [self.searchButton setImage:[UIImage imageNamed:@"noResultSearchButton.png"] forState:UIControlStateNormal];
        [self.noDataFrame   addSubview: self.searchButton toTop:@146 right:nil bottom:nil left:@28];
    }
    return self;
}


@end
