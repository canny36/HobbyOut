//
//  TvBroadcast.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TvBroadcast.h"

#import "Meeting.h"
#import "TribuneMeeting.h"
#import "MemberMeeting.h"
#import "OtherMeeting.h"

@implementation TvBroadcast

-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
        self.data = data;
        self.name = [data objectForKey:@"name"];
        self.fullpath = [data objectForKey:@"fullpath"];
        
        if ([data objectForKey:@"diffuseur_icone"])
            self.broadcasterPath = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"diffuseur_icone"]];
        
        
        self.hour = [[data objectForKey:@"date_start"] substringWithRange:NSMakeRange(11, 5)];
        self.hour = [self.hour stringByReplacingOccurrencesOfString:@":" withString:@"H"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormat dateFromString:[data objectForKey:@"date_start"]];
        [dateFormat setDateFormat:@"dd MMMM yyyy - HH'H'mm"];
        self.fullDate = [[dateFormat stringFromDate:date] uppercaseString];
        [dateFormat setDateFormat:@"EEEE dd MMMM yyyy"];
        self.fullWithDayDate = [[dateFormat stringFromDate:date] lowercaseString];
        
        self.meetings = [[NSMutableArray alloc] init];
        
        if ([data objectForKey:@"meetings"] != [NSNull null])
        {
            for (NSDictionary *meetingData in [data objectForKey:@"meetings"])
            {
                [self.meetings addObject:[Meeting getMeetingFromDictionary:meetingData]];
            }
        }
    }
    
    return self;
}

- (UIImage *) icone
{
    if (![self.sport isEqualToString:@"Tous les sports"])
    {
        NSString *fileName = [[NSString stringWithFormat:@"%@Icon", self.sport] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"-/-" withString:@"-"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"'" withString:@"-"];
    
        return [UIImage imageNamed:fileName];
    }
    
    return [UIImage imageNamed:@"allSportsIcon"];
}

- (NSString *) sport
{
    if (self.fullpath && ![self.fullpath  isEqual:[NSNull null]])
    {
        NSArray *path = [self.fullpath componentsSeparatedByString:@"|"];
        return[path objectAtIndex:0];
    }
     return @"Tous les sports";
}

- (NSString *) category
{
    if (self.fullpath && ![self.fullpath  isEqual:[NSNull null]])
    {
        NSArray *path = [self.fullpath componentsSeparatedByString:@"|"];
        return  [path objectAtIndex:[path count] - 1];
    }
    return @"Tous les sports";
}

@end
