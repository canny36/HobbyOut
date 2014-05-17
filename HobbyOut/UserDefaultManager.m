//
//  UserDefaultManager.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 24/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "UserDefaultManager.h"

@implementation UserDefaultManager

+(void) setSessionToken:(NSString *) token
{
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:SESSION_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *) getSessionToken
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:SESSION_TOKEN];
}

+(void) setUser:(NSDictionary *)user
{
    
    NSMutableDictionary *cleanUser = [NSMutableDictionary dictionary];
    
    NSLog(@"User Dictionary %@ ",user);
    
    for (NSString * key in [user allKeys])
    {
        if (![[user objectForKey:key] isKindOfClass:[NSNull class]])
            [cleanUser setObject:[user objectForKey:key] forKey:key];
    }
  
    NSMutableArray *cleanOrganisingMeetings  = [[NSMutableArray alloc] init];
    
    
    if ([cleanUser objectForKey:@"meetings_organising"])
    {
        for (NSDictionary *meetingOrganisingData in [cleanUser objectForKey:@"meetings_organising"])
        {
            NSMutableDictionary *cleanOrganisingMeeting = [NSMutableDictionary dictionary];
            
            for (NSString * key in [meetingOrganisingData allKeys])
            {
                if (![[meetingOrganisingData objectForKey:key] isKindOfClass:[NSNull class]])
                    [cleanOrganisingMeeting setObject:[meetingOrganisingData objectForKey:key] forKey:key];
            }
            
            [cleanOrganisingMeetings addObject:cleanOrganisingMeeting];
        }
        
        [cleanUser setObject:cleanOrganisingMeetings forKey:@"meetings_organising"];
    }
    
    
    NSMutableArray *cleanParticipatingMeetings  = [[NSMutableArray alloc] init];
    
    if ([cleanUser objectForKey:@"meetings_participating"])
    {
        
        for (NSDictionary *meetingParticipationgData in [cleanUser objectForKey:@"meetings_participating"])
        {
            NSMutableDictionary *cleanParticipatingMeeting = [NSMutableDictionary dictionary];
            
            for (NSString * key in [meetingParticipationgData allKeys])
            {
                if (![[meetingParticipationgData objectForKey:key] isKindOfClass:[NSNull class]])
                    [cleanParticipatingMeeting setObject:[meetingParticipationgData objectForKey:key] forKey:key];
            }
            
            [cleanParticipatingMeetings addObject:cleanParticipatingMeeting];
        }
        
        [cleanUser setObject:cleanParticipatingMeetings forKey:@"meetings_participating"];
    
    }
    
    NSMutableArray *cleanFriends  = [[NSMutableArray alloc] init];
    
    if ([cleanUser objectForKey:@"friends"])
    {
        
        for (NSDictionary *userData in [cleanUser objectForKey:@"friends"])
        {
            NSMutableDictionary *cleanUserData = [NSMutableDictionary dictionary];
            
            for (NSString * key in [userData allKeys])
            {
                if (![[userData objectForKey:key] isKindOfClass:[NSNull class]])
                    [cleanUserData setObject:[userData objectForKey:key] forKey:key];
            }
            
            [cleanFriends addObject:cleanUserData];
        }
        
        [cleanUser setObject:cleanFriends forKey:@"friends"];
        
    }
    
    [[NSUserDefaults standardUserDefaults] setValue:cleanUser forKey:USER];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(Member *) getUser
{
    NSDictionary *data = [[NSUserDefaults standardUserDefaults] dictionaryForKey:USER];
    
    if (data)
        return [[Member alloc] initWithDictionary:data];
    
    return nil;
}

+(void) logout
{
    if ([[NSUserDefaults standardUserDefaults] valueForKey:USER])
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER];
    if ([[NSUserDefaults standardUserDefaults] valueForKey:SESSION_TOKEN])
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:SESSION_TOKEN];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
