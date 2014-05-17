//
//  Meetings.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 11/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MeetingsService.h"
#import "Meeting.h"

@implementation MeetingsService

-(id) initWithDelegate:(id<MeetingsServiceDelegate>) delegate
{
    self = [super initWithPath:@"meetings"];
    
    if (self)
    {
        self.delegate = delegate;
    }
    
    return self;
}

-(void) onSuccess:(NSDictionary*) response
{

    BOOL success = [[response valueForKey:@"success"] boolValue];
    
    if (success)
    {
        NSMutableDictionary *meetingDico = [NSMutableDictionary dictionary];
        NSMutableArray *categoryArray = [NSMutableArray array];
        
        NSLog(@"MEETINGS : %@", response.description);
        
        for (NSDictionary *meetingData in [response objectForKey:@"meetings"])
        {
            Meeting *meeting = [Meeting getMeetingFromDictionary:meetingData];
            
            if (![meetingDico objectForKey:meeting.sport])
            {
                [meetingDico setValue:[NSMutableArray array] forKey:meeting.sport];
                [categoryArray addObject:meeting.sport];
            }
            
           [[meetingDico objectForKey:meeting.sport] addObject:meeting];
        }
        
        if (self.delegate)
            [self.delegate meetingsRetrieved:self meetingByCategory:meetingDico andCategoryArray:categoryArray];
            
        
    }
}

@end
