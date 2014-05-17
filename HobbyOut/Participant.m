//
//  Participant.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "Participant.h"

@implementation Participant

-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
        self.userId = [data objectForKey:@"id"];
        self.name = [data objectForKey:@"username"];
        self.avatarUrl = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"avatar"]];
    }
    
    return self;
}

-(id) initWithName:(NSString *)name userId:(NSString *) userId andAvatarUrl:(NSString *) avatarUrl
{
    self = [super init];
    
    if (self)
    {
        self.userId = userId;
        self.name = name;
        self.avatarUrl = avatarUrl;
    }
    
    return self;
}

@end
