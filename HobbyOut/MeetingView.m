//
//  MeetingView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 28/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MeetingView.h"
#import "AppStyle.h"
#import "UIAbsolutView.h"

#import "AppStyle.h"

@implementation MeetingView

- (id)init{
    self = [super initWithFrame:[UIScreen mainScreen].applicationFrame];


    if (self) {
        self.gap = 0;
        self.padding = 0;
        [self setBackgroundColor:[AppStyle backgroundColor]];
        
        UIAbsolutView *headerView = [[UIAbsolutView alloc] init];
        [headerView setBackgroundImage:@"meetingHeader.png"];
        [self layoutSubview:headerView withSize:CGSizeMake(320, 120)];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        [AppStyle meetingDateLabel:self.dateLabel];
        [headerView addSubview:self.dateLabel toTop:@5 right:@80 bottom:nil left:@80];
        
        self.categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        [AppStyle eventGreyLabel:self.categoryLabel];
        [headerView addSubview:self.categoryLabel toTop:@36 right:@10 bottom:nil left:@195];
        
        self.broadcasterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 26)];
        self.broadcasterImageView.contentMode = UIViewContentModeScaleAspectFit;
        [headerView addSubview:self.broadcasterImageView toTop:@35 right:nil bottom:nil left:@100];
        
        self.nameLabel = [[UILabel alloc] init];
        [AppStyle meetingEventNameLabel:self.nameLabel];
        [headerView addSubview:self.nameLabel toTop:@60 right:@5 bottom:@15 left:@5];
        
        self.meetingTableView = [[UITableView alloc] init];
        self.meetingTableView.rowHeight = 138;
        self.meetingTableView.backgroundColor = [UIColor clearColor];
        self.meetingTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self layoutSubview:self.meetingTableView withSize:CGSizeMake(320,
                                                                    self.frame.size.height - headerView.frame.size.height - 48)];
        
    }
    return self;
}



@end
