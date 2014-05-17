//
//  InviteFriendService.m
//  HobbyOut
//
//  Created by Srinivas on 26/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "InviteFriendService.h"

@implementation InviteFriendService


//http://www.hobbyout.com/api/meeting/invitation/?key=API_KEY&token=USER_TOKEN
-(id) init
{
    self = [super initWithPath:@"meeting/invitation"];
    
    if (self)
    {

    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{
    NSLog(@"FRIEND REQUEST : %@", response);
    
    if (self.onSuccess)
        _onSuccess(response);
}


- (void) onFail:(NSString*)message{
    _onFail(message);
}

@end
