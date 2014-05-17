//
//  TvView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TvView.h"

#import "UIAbsolutView.h"
#import "AppStyle.h"
#import "UIColor+category.h"


@implementation TvView

- (id)init{
    self = [super initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.gap = 0;
    self.padding = 0;
    
    if (self) {
        [self setBackgroundColor:[AppStyle backgroundColor]];
        
        UIAbsolutView *headerView = [[UIAbsolutView alloc] init];
        [self layoutSubview:headerView withSize:CGSizeMake(320, 48)];
        
        self.dateLabel = [[UILabel alloc] init];
        [AppStyle headerText:self.dateLabel];
        [headerView addSubview:self.dateLabel toTop:@0 right:@50 bottom:@-3 left:@5];
        
        self.calendarButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 34)];
        [self.calendarButton setImage:[UIImage imageNamed:@"planningButton.png"] forState:UIControlStateNormal];
        [headerView addSubview: self.calendarButton toTop:@10 right:@5 bottom:nil left:nil];
        
        self.tvTableView = [[UITableView alloc] init];
        self.tvTableView.rowHeight = 125;
        self.tvTableView.sectionHeaderHeight = 61;
        self.tvTableView.backgroundColor = [UIColor clearColor];
        self.tvTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self layoutSubview:self.tvTableView withSize:CGSizeMake(320,
                                                                    self.frame.size.height - headerView.frame.size.height - 48)];
        
        self.noDataFrame = [[UIAbsolutView alloc] initWithFrame:CGRectMake(0, 70, 320, 215)];
        [self.noDataFrame setBackgroundImage:@"noResultAgendaPanel.png"];
        self.noDataFrame.hidden = YES;
        [self addSubview:self.noDataFrame];
        
        
        self.searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 267, 49)];
        [self.searchButton setImage:[UIImage imageNamed:@"noResultSearchButton.png"] forState:UIControlStateNormal];
        [self.noDataFrame   addSubview: self.searchButton toTop:@146 right:nil bottom:nil left:@28];
        
        
    }
    return self;
}

@end
