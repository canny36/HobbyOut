//
//  LoginService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 23/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "LoginService.h"
#import "HobbyOutAPIClient.h"
#import "UserDefaultManager.h"

@implementation LoginService

-(id) initWithDelegate:(id<LoginServiceDelegate>) delegate
{
    self = [super initWithPath:@"login"];
    
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
        
        NSLog(@" Response login : %@", response.description);
        
        if (success)
        {
            [UserDefaultManager setUser:[response valueForKey:@"member"]];
            [UserDefaultManager setSessionToken:[response valueForKey:@"token"]];
            
            [self.delegate loginSucess:self];
        }
        else
        {
            [self.delegate loginFail:self message:[response valueForKey:@"message"]];
        }
    }
    
}

@end
