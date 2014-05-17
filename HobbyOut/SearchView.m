//
//  SearchView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 30/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "SearchView.h"
#import "AppStyle.h"

@implementation SearchView

- (id)init{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 48)];
    
    
    if (self) {
        [self setBackgroundColor:[AppStyle backgroundColor]];

        self.tableView = [[UITableView alloc] initWithFrame:self.frame];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.rowHeight = 165;
        self.tableView.sectionHeaderHeight = 61;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView];
        
        
        self.noDataFrame = [[UIAbsolutView alloc] initWithFrame:CGRectMake(0, 70, 320, 98)];
        [self.noDataFrame setBackgroundImage:@"noResultSearch"];
        self.noDataFrame.hidden = YES;
        [self addSubview:self.noDataFrame];
    }
    return self;
}

@end
