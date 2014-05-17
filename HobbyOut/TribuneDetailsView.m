//
//  TribuneDetailsView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 24/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TribuneDetailsView.h"
#import "AppStyle.h"

@implementation TribuneDetailsView

- (id)init{
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, applicationFrame.size.width,
                                           applicationFrame.size.height - 48)];
    
    if (self)
    {
        
        [self setBackgroundColor:[AppStyle backgroundColor]];

        self.tableView = [[UITableView alloc] init];
        self.tableView.rowHeight = 161;
        self.tableView.sectionHeaderHeight = 20;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.tableView toTop:@285 right:@10 bottom:@0 left:@10];

        
        self.eventsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 53)];
        [self.eventsButton setImage:[UIImage imageNamed:@"tribuneEventButton.png"]
                           forState:UIControlStateSelected];
        [self.eventsButton setImage:[UIImage imageNamed:@"tribuneEventButton.png"]
                           forState:UIControlStateHighlighted];
        [self.eventsButton setImage:[UIImage imageNamed:@"tribuneEventButtonOff.png"]
                           forState:UIControlStateNormal];
        [self addSubview:self.eventsButton toTop:@226 right:nil bottom:nil left:@0];
        self.eventsButton.selected = YES;
        
        self.broadcastsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 160, 53)];
        [self.broadcastsButton setImage:[UIImage imageNamed:@"tribuneTVButton.png"]
                           forState:UIControlStateSelected];
        
        [self.broadcastsButton setImage:[UIImage imageNamed:@"tribuneTVButton.png"]
                           forState:UIControlStateHighlighted];
        
        [self.broadcastsButton setImage:[UIImage imageNamed:@"tribuneTVButtonOff.png"]
                           forState:UIControlStateNormal];
        
        [self addSubview:self.broadcastsButton toTop:@226 right:nil bottom:nil left:@160];
        
        
        UIAbsolutView *headerView = [[UIAbsolutView alloc] initWithFrame:CGRectMake(0, 0, 320, 227)];
        [headerView setBackgroundImage:@"trinuneHeader.png"];
        [self addSubview:headerView toTop:@0 right:@0 bottom:nil left:@0];
        
        self.tribuneHeaderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 112)];
        [headerView addSubview:self.tribuneHeaderImageView toTop:@0 right:@0 bottom:nil left:@0];
        
        self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 85, 65)];
        self.avatarView.transform = CGAffineTransformMakeRotation(-6.3 * M_PI/180);
        self.avatarView.backgroundColor = [UIColor blackColor];
        [headerView addSubview:self.avatarView toTop:@20 right:nil bottom:nil left:@-10];
        
        
        self.mapButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 34)];
        [self.mapButton setImage:[UIImage imageNamed:@"geolocButton.png"] forState:UIControlStateNormal];
        [self addSubview:self.mapButton toTop:@131 right:nil bottom:nil left:@268];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingDistanceLabel:self.distanceLabel];
        [self addSubview:self.distanceLabel toTop:@135 right:@10 bottom:nil left:@23];
        
        self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 25)];
        [AppStyle meetingAdressLabel:self.addressLabel];
        [self addSubview:self.addressLabel toTop:@121 right:@50 bottom:nil left:@85];
        
        self.address2Label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 40)];
        [AppStyle meetingAdressLabel:self.address2Label];
        [self addSubview:self.address2Label toTop:@135 right:@50 bottom:nil left:@85];
        
        self.equipmentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        [AppStyle tribuneTvNumverLabel:self.equipmentLabel];
        [self addSubview:self.equipmentLabel toTop:@187 right:@10 bottom:nil left:@170];
        
        self.tribuneTypeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 54, 35)];
        [self addSubview:self.tribuneTypeImageView toTop:@70 right:nil bottom:nil left:@85];
        
        
        self.barCategoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        [AppStyle tribuneTypeLabel:self.barCategoryLabel];
        [self addSubview:self.barCategoryLabel toTop:@80 right:@10 bottom:nil left:@155];
        
        
    }
    return self;
}

@end
