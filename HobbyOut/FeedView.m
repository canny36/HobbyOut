//
//  FeedView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "FeedView.h"
#import "AppStyle.h"

@implementation FeedView

- (id)init
{
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height - 48)];
    
    if (self) {
        self.backgroundColor = [AppStyle backgroundColor];
        
        self.tableView = [[UITableView alloc] init];
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = 172;
        [self addSubview:self.tableView toTop:@10 right:@8 bottom:@10 left:@8];
        
        self.noDataFrame = [[UIAbsolutView alloc] initWithFrame:CGRectMake(0, 70, 320, 98)];
        [self.noDataFrame setBackgroundImage:@"noNews"];
        self.noDataFrame.hidden = YES;
        [self addSubview:self.noDataFrame];
        
    }
    
    return self;
}



@end
