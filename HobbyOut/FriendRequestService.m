//
//  FriendRequestService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "FriendRequestService.h"

@implementation FriendRequestService

-(id) initWithDelegate:(id<FriendRequestDelegate>) delegate
{
    self = [super initWithPath:@"user/connection"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{
    NSLog(@"FRIEND REQUEST : %@", response);
    
    if (self.delegate)
        [self.delegate requestAnswered];
}


@end
