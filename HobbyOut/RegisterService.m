//
//  RegisterService.m
//  HobbyOut
//
//  Created by Srinivas on 06/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "RegisterService.h"


@implementation RegisterService
-(id) initWithDelegate:(id<RegisterServiceDelegate>) delegate
{
    self = [super initWithPath:@"registration/check"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}



-(id) initWithRegisterDelegate:(id<RegisterServiceDelegate>) delegate
{
    self = [super initWithPath:@"registration"];
    
    if (self)
    {
        self.tag = 100;
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
            
            [self.delegate registerSucess:self response:response];
        }
        else
        {
            [self.delegate registerFail:self message:response[@"message"]];
        }
    }
    
}

@end
