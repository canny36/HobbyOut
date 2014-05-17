//
//  EventService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 25/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "EventService.h"
#import "TvBroadcast.h"
@implementation EventService


-(id) initWithDelegate:(id<EventServiceDelegate>) delegate
{
    self = [super initWithPath:@"events"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}


-(void) onSuccess:(NSDictionary*) response
{
    NSLog(@"Response Event : %@", response.description);
    if (self.delegate)
    {
        NSMutableArray *events = [[NSMutableArray alloc] init];
        
        for (NSDictionary* event in [response objectForKey:@"events"])
        {
            [events addObject:[[TvBroadcast alloc] initWithDictionary:event]];
        }
        
        [self.delegate eventServiceSuccess:self eventArray:events];
    }
    
    
    
}
@end


