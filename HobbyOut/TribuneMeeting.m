//
//  TribuneMeeting.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 29/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TribuneMeeting.h"

@implementation TribuneMeeting


-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super initWithDictionary:data];
    
    if (self)
    {
        self.etablissement = [data objectForKey:@"etablissement"];
        self.lieu = [data objectForKey:@"lieu"];
    }
    
    return self;
}

-(NSString *) getName
{
    return self.lieu;
}

@end
