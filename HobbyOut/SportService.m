//
//  SportService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 17/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "SportService.h"
#import "Sport.h"

@implementation SportService


-(id) initWithDelegate:(id<SportServiceDelegate>) delegate
{
    self = [super initWithPath:@"categories"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{
    NSLog(@"RESPONSE MEETINGS: %@", response.description);
    BOOL success = [[response valueForKey:@"success"] boolValue];
    
   // if (success)
    //{
        if (self.delegate)
            [self.delegate sportRetrieved:[Sport sportsFormDataArray:[response valueForKey:@"categories"]]];
    //}
}

@end
