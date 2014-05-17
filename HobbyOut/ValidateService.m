//
//  ValidateService.m
//  HobbyOut
//
//  Created by Srinivas on 01/05/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "ValidateService.h"

@implementation ValidateService

-(id) initWithDelegate:(void(^)(NSDictionary *response))onsuccess
{
    self = [super initWithPath:@"registration/check"];
    
    if (self)
    {
        _onSuccess = onsuccess;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*)response
{
    if (_onSuccess)
    {
        _onSuccess(response);
    }
    
}

@end
