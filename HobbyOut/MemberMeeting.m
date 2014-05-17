//
//  MemberMeeting.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 29/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MemberMeeting.h"

@implementation MemberMeeting

-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super initWithDictionary:data];
    
    if (self)
    {
        self.userName = [data objectForKey:@"username"];
    }
    
    return self;
}

-(NSString *) getName
{
    return self.userName;
}

@end
