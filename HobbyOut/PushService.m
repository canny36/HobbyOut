//
//  PushService.m
//  HobbyOut
//
//  Created by Srinivas on 30/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "PushService.h"

@implementation PushService

-(id) initWithDelegate:(onSuccess) successBlock
{
    self = [super initWithPath:@"push"];
    
    if (self)
    {
        self.success = successBlock;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{
    NSLog(@"REPSONSE PUSH  : %@", response.description );
    BOOL success = [[response valueForKey:@"success"] boolValue];
    
    if (success)
    {
        _success(response);
        //        [self.delegate memberRetreved:self andMemberData:[response valueForKey:@"member"]];
    }
}


@end
