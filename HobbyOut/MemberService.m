//
//  MemberService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 10/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MemberService.h"

@implementation MemberService

-(id) initWithDelegate:(id<MemberServiceDelegate>) delegate
{
    self = [super initWithPath:@"user"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{
    NSLog(@"REPSONSE MEMBER : %@", response.description );
    BOOL success = [[response valueForKey:@"success"] boolValue];
    
    if (success)
    {
        [self.delegate memberRetreved:self andMemberData:[response valueForKey:@"member"]];
    }
}

@end
