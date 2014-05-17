//
//  Invitation.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 13/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "Invitation.h"
#import "MemberMeeting.h"

@implementation Invitation


-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
        NSLog(@"FEED : %@", data.description);
        
        self.eventName = [data objectForKey:@"event_name"];
        
        self.hour = [[data objectForKey:@"date_start"] substringWithRange:NSMakeRange(11, 5)];
        self.hour = [self.hour stringByReplacingOccurrencesOfString:@":" withString:@"h"];
        
        self.memberId = [data objectForKey:@"demand_member_id"];
        self.otherMemberId = [data objectForKey:@"member_id"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormat dateFromString:[data objectForKey:@"date_start"]];
        [dateFormat setDateFormat:@"dd MMMM yyyy"];
        self.fullDate = [[dateFormat stringFromDate:date] uppercaseString];
        [dateFormat setDateFormat:@"EEEE dd MMMM yyyy"];
        self.fullWithDayDate = [[dateFormat stringFromDate:date] lowercaseString];
        
        
        self.meetingTitle = [data objectForKey:@"meeting_title"];
        self.meetingId = [data objectForKey:@"meeting_id"];
        self.eventCategory = [data objectForKey:@"event_category"];

        self.username = [data objectForKey:@"username"];
        self.avatarUrl = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"avatar"]];
        
        self.meeting = [Meeting getMeetingFromDictionary:data];
        
        if ([self.meeting isKindOfClass:[MemberMeeting class]])
        {
            ((MemberMeeting *)self.meeting).userName = [data objectForKey:@"lieu"];
            
            if ([data objectForKey:@"organiser_avatar"])
                ((MemberMeeting *)self.meeting).avatar =  [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"organiser_avatar"]];
        }
    }
    
    return self;
}

@end
