//
//  AddSportView.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 17/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AddSportView.h"

@implementation AddSportView

- (id)init
{
    CGRect applicationFrame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame:CGRectMake(0, 0, applicationFrame.size.width, applicationFrame.size.height - 48)];
    
    if (self) {
        self.tableView = [[UITableView alloc] initWithFrame:self.frame];
        [self addSubview:self.tableView];

    }
    return self;
}

@end
