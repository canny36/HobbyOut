//
//  ParticipateService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 04/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "ParticipateService.h"

@implementation ParticipateService

-(id) initWithDelegate:(id<ParticipateServiceDelegate>) delegate
{
    self = [super initWithPath:@"meeting/participate"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{
    NSLog(@"Particpate response : %@", response.description);
    
    BOOL success = [[response valueForKey:@"success"] boolValue];
    
    if (success)
    {
        NSInteger status = [[response valueForKey:@"status"] integerValue];
        
        [self.delegate participate:self status:status];
        
    }
    
}
    
@end
