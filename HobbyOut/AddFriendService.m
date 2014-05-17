//
//  AddFriendService.m
//  HobbyOut
//
//  Created by Srinivas on 30/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "AddFriendService.h"

@implementation AddFriendService
-(id) initWithDelegate:(onSuccess) successBlock
{
    self = [super initWithPath:@"user/connection"];
    
    if (self)
    {
        self.success = successBlock;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{
    
     _success(response);
//    NSLog(@"REPSONSE MEMBER : %@", response.description );
//    BOOL success = [[response valueForKey:@"success"] boolValue];
//    
//    if (success)
//    {
//       
////        [self.delegate memberRetreved:self andMemberData:[response valueForKey:@"member"]];
//    }
}
@end
