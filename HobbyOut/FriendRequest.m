//
//  FriendRequest.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 13/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "FriendRequest.h"

@implementation FriendRequest

-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
        self.memberId = [data objectForKey:@"member_id"];
        self.username = [data objectForKey:@"username"];
        self.avatarUrl = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"avatar"]];
    }
    
    return self;
}

@end
