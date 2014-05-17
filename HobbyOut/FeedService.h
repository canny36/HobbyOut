//
//  FeedService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@protocol FeedServiceDelegate

- (void) feedRetreived:(NSArray *) friends invitations:(NSArray *) invitations participations:(NSArray *) participations;

@end

@interface FeedService : AbstractService

@property(nonatomic) id<FeedServiceDelegate> delegate;
-(id) initWithDelegate:(id<FeedServiceDelegate>) delegate;

@end
