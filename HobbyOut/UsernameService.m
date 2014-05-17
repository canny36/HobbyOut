//
//  UsernameService.m
//  HobbyOut
//
//  Created by Srinivas on 06/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "UsernameService.h"

@implementation UsernameService
-(id) initWithDelegate:(id<UsernameServiceDelegate>) delegate
{
    self = [super initWithPath:@"registration/check"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*)response
{
    if (self.delegate)
    {
        BOOL success = [[response valueForKey:@"success"] boolValue];
        
        NSLog(@" Response userName : %@", response.description);
        
        if (success)
        {
                 
            [self.delegate usernameSucess:self];
        }
        else
        {
            [self.delegate usernameFail:self message:@""];
        }
    }
    
}
@end
