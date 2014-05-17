//
//  EventService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@protocol EventServiceDelegate;

@interface EventService : AbstractService

@property (nonatomic) id<EventServiceDelegate> delegate;

-(id) initWithDelegate:(id<EventServiceDelegate>) delegate;


@end


@protocol EventServiceDelegate

- (void) eventServiceSuccess:(EventService*)eventService  eventArray:(NSArray *) events;


@end