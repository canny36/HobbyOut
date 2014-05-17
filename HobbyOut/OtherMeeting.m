//
//  OtherMeeting.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 04/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "OtherMeeting.h"

@implementation OtherMeeting

-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super initWithDictionary:data];
    
    if (self)
    {
        self.lieu = [data objectForKey:@"lieu"];
    }
    
    return self;
}

-(NSString *) getName
{
    return self.lieu;
}

@end
