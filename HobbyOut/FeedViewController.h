//
//  FeedViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedService.h"
#import "FriendRequestService.h"
#import "ParticipateService.h"

@interface FeedViewController : UIViewController

@property(nonatomic) FeedService *feedService;
@property(nonatomic) FriendRequestService *friendRequestService;
@property(nonatomic) ParticipateService *participateService;
@property(nonatomic) UIRefreshControl *refreshControl;

@end
