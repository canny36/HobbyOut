//
//  FriendRequestService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@protocol FriendRequestDelegate

- (void) requestAnswered;

@end

@interface FriendRequestService : AbstractService

@property(nonatomic) id<FriendRequestDelegate> delegate;

-(id) initWithDelegate:(id<FriendRequestDelegate>) delegate;

@end
