//
//  TvViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventService.h"

#import "TrackedViewController.h"

@interface TvViewController : TrackedViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic) EventService *eventService;
@property(nonatomic) UIRefreshControl *refreshControl;

@end
