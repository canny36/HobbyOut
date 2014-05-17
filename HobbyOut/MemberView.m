//
//  MemberView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 05/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MemberView.h"
#import "AppStyle.h"
#import "UIVView.h"

@implementation MemberView

- (id)init{
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height - 48)];
    
    
    if (self) {

        [self setBackgroundColor:[AppStyle backgroundColor]];
    
        self.sportsTableView = [[UITableView alloc] init];
        self.sportsTableView.rowHeight = 103;
        self.sportsTableView.backgroundColor = [UIColor clearColor];
        self.sportsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sportsTableView.showsVerticalScrollIndicator = NO;
        self.sportsTableView.transform = CGAffineTransformRotate(CGAffineTransformIdentity, -90 * M_PI / 180.0);
        self.sportsTableView.frame = CGRectMake(0, 15, 315, 103);
        self.sportsTableView.hidden = YES;
        
        self.eventsTableView = [[UITableView alloc] init];
        self.eventsTableView.rowHeight = 161;
        self.eventsTableView.sectionHeaderHeight = 20;
        self.eventsTableView.backgroundColor = [UIColor clearColor];
        self.eventsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:self.eventsTableView toTop:@115 right:@10 bottom:@0 left:@10];
        
        UIAbsolutView *headerView = [[UIAbsolutView alloc] initWithFrame:CGRectMake(0, 0, 320, 123)];
        [headerView setBackgroundImage:@"memberHeader.png"];
        [self addSubview:headerView toTop:@0 right:@0 bottom:nil left:@0];
        
        self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 85, 65)];
        self.avatarView.transform = CGAffineTransformMakeRotation(-6.3 * M_PI/180);
        self.avatarView.backgroundColor = [UIColor blackColor];
        [headerView addSubview:self.avatarView toTop:@20 right:nil bottom:nil left:@-10];
        
        self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        [AppStyle memberDescLabel:self.descLabel];
        [headerView addSubview:self.descLabel toTop:@10 right:@60 bottom:nil left:@100];
        
        
        self.editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
        [self.editButton setImage:[UIImage imageNamed:@"editProfilButton"] forState:UIControlStateNormal];
//        [headerView addSubview:self.editButton toTop:@13 right:@5 bottom:nil left:nil];
        
        self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
        [self.cancelButton setImage:[UIImage imageNamed:@"cancelProfil"] forState:UIControlStateNormal];
        self.cancelButton.hidden = YES;
//        [headerView addSubview:self.cancelButton toTop:@13 right:@5 bottom:nil left:nil];
        
        self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 45, 25)];
        [self.okButton setImage:[UIImage imageNamed:@"okProfil"] forState:UIControlStateNormal];
        self.okButton.hidden = YES;
//        [headerView addSubview:self.okButton toTop:@13 right:@55 bottom:nil left:nil];
        
        
        self.badgeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        [AppStyle memberBadgeLabel:self.badgeLabel];
        [headerView addSubview:self.badgeLabel toTop:@60 right:@10 bottom:nil left:@100];
        
        self.pointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 20)];
        [AppStyle memberPointsLabel:self.pointLabel];
        [headerView addSubview:self.pointLabel toTop:@80 right:@10 bottom:nil left:@100];

        
        
        self.addButton =  [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 25)];
        [self.addButton setImage:[UIImage imageNamed:@"addSport"] forState:UIControlStateNormal];
        self.addButton.hidden = YES;
        [self addSubview:self.addButton toTop:@132 right:@3 bottom:nil left:nil];
        
        
    }
    
    return self;
}


@end
