//
//  EventListViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingsService.h"

#import "TrackedViewController.h"

@interface EventListViewController : TrackedViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) MeetingsService *meetingsServices;
@property(nonatomic) UIRefreshControl *refreshControl;

@end
