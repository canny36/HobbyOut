//
//  FeedService.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "FeedService.h"
#import "FriendRequest.h"
#import "Invitation.h"
#import "ParticipationRequest.h"


@implementation FeedService

-(id) initWithDelegate:(id<FeedServiceDelegate>) delegate
{
    self = [super initWithPath:@"user/news"];
    
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
    
    if (success)
    {
        NSMutableArray *friendRequests = [NSMutableArray array];
        if ([response valueForKey:@"friend_request"])
        {
            for (NSDictionary *friendRequestData in [response valueForKey:@"friend_request"])
            {
                [friendRequests addObject:[[FriendRequest alloc] initWithDictionary:friendRequestData]];
            }
        }
        
        NSMutableArray *invitations = [NSMutableArray array];
        if ([response valueForKey:@"invitations"])
        {
            for (NSDictionary *invitationData in [response valueForKey:@"invitations"])
            {
                [invitations addObject:[[Invitation alloc] initWithDictionary:invitationData]];
            }
        }
        
        NSMutableArray *participationRequests = [NSMutableArray array];
        if ([response valueForKey:@"participation_request"])
        {
            for (NSDictionary *participationRequestData in [response valueForKey:@"participation_request"])
            {
                [participationRequests addObject:[[ParticipationRequest alloc] initWithDictionary:participationRequestData]];
            }
        }
    
        if (self.delegate)
        {
            [self.delegate feedRetreived:friendRequests invitations:invitations participations:participationRequests];
        }
        
    }
}



@end
