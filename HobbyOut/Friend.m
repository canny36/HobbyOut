//
//  Friend.m
//  HobbyOut
//
//  Created by Srinivas on 15/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "Friend.h"

@implementation Friend

-(id)initWithDictionary:(NSDictionary*)data{
    self = [super init];
    if (self) {
        
        _avatar = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"avatar"]];
        _distance = data[@"distance"];
        _friendId = data[@"id"];
        _username = data[@"username"];
        
    }
    return self;
}

@end
