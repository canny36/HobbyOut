//
//  LoginFacebookService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 30/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "LoginFacebookService.h"

@implementation LoginFacebookService

-(id) initWithDelegate:(id<LoginServiceDelegate>) delegate
{
    self = [super initWithPath:@"login/facebook"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}

@end
