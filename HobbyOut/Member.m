//
//  Member.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 04/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "Member.h"
#import "Sport.h"
#import "Meeting.h"
#import "Friend.h"
#import "TvBroadcast.h"

@implementation Member

-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    
    if (self)
    {
     
        NSLog(@"Member response %@ ",data);
        self.memberId = [data objectForKey:@"id"];
        self.name = [data objectForKey:@"name"];
        self.username = [data objectForKey:@"username"];
        self.badge = [data objectForKey:@"badge"];
        
        self.points = @"0";
       
        if ([data objectForKey:@"points"] != [NSNull null] )
            self.points = [data objectForKey:@"points"];
        
        self.adresse = [data objectForKey:@"adresse"];
        self.ville = [data objectForKey:@"ville"];
        self.postcode = [data objectForKey:@"postcode"];
       
        if ([data objectForKey:@"nb_tv"] != [NSNull null] )
            self.nbTV = [[data objectForKey:@"nb_tv"] integerValue];
        
        if ([data objectForKey:@"etablissement"] != [NSNull null] )
            self.etablissement = [data objectForKey:@"etablissement"];
        
        if ([data objectForKey:@"etablissement"] != [NSNull null] )
            self.friendStatus = [[data objectForKey:@"friend_status"] integerValue];
        
        if ([data objectForKey:@"distance"] != [NSNull null] )
            self.distance = [[data objectForKey:@"distance"] floatValue];
        
        if ([data objectForKey:@"lat"] != [NSNull null])
            _coordinate.latitude = [[data objectForKey:@"lat"] floatValue] ;
        
        if ([data objectForKey:@"lng"] != [NSNull null])
            _coordinate.longitude = [[data objectForKey:@"lng"] floatValue];
        
        if ([data objectForKey:@"type_etablissement"] != [NSNull null])
            self.typeEtab = [[data objectForKey:@"type_etablissement"] integerValue];
        
        self.avatarUrl = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"avatar"]];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        
        if ([data objectForKey:@"birth_date"]  &&
            [data objectForKey:@"birth_date"] != [NSNull null])
        {
            NSDate *date = [dateFormat dateFromString:[data objectForKey:@"birth_date"]];
            NSDate *now = [NSDate date];
            
            NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
            NSDateComponents *components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                                                       fromDate:date
                                                         toDate:now
                                                        options:0];
            self.age = components.year;
            
        }
        
        
        self.categories = [[NSMutableArray alloc] init];
        
        if ([data objectForKey:@"gender"] &&
            [data objectForKey:@"gender"] != [NSNull null])
        {
            if ([[data objectForKey:@"gender"] isEqual:@"1"] )
            {
                self.gender = @"Homme";
            }
            else
            {
                self.gender = @"Femme";
            }
        }
        
        if ([data objectForKey:@"categories"] &&
            [data objectForKey:@"categories"] != [NSNull null])
        {
            for (NSDictionary *sportData in [data objectForKey:@"categories"])
            {
                Sport *sport = [[Sport alloc] initWithDictionary:sportData];
                [self.categories addObject:sport];
            }

        }
        
        self.meetingsOrganising = [[NSMutableArray alloc] init];
        if ([data objectForKey:@"meetings_organising"] &&
            [data objectForKey:@"meetings_organising"] != [NSNull null])
        {
            for (NSDictionary *meetingOrganisingData in [data objectForKey:@"meetings_organising"])
            {
                [self.meetingsOrganising addObject:[Meeting getMeetingFromDictionary:meetingOrganisingData]];
            }
            
        }
        
        self.meetingsParticipating = [[NSMutableArray alloc] init];
        if ([data objectForKey:@"meetings_participating"] &&
            [data objectForKey:@"meetings_participating"] != [NSNull null])
        {
            for (NSDictionary *meetingsParticipatingData in [data objectForKey:@"meetings_participating"])
            {
                [self.meetingsParticipating addObject:[Meeting getMeetingFromDictionary:meetingsParticipatingData]];
            }
            
        }
        
        self.tvBroadcasts = [[NSMutableArray alloc] init];
        if ([data objectForKey:@"diffusions"] &&
            [data objectForKey:@"diffusions"] != [NSNull null])
        {
            for (NSDictionary *broadcastData in [data objectForKey:@"diffusions"])
            {
                [self.tvBroadcasts addObject:[[TvBroadcast alloc ] initWithDictionary:broadcastData]];
            }
            
        }
        
        self.friends = [[NSMutableArray alloc] init];
        if ([data objectForKey:@"friends"] &&
            [data objectForKey:@"friends"] != [NSNull null])
        {
            for (NSDictionary *friendData in [data objectForKey:@"friends"])
            {
                [self.friends addObject:[[Friend alloc ] initWithDictionary:friendData]];
            }
            
        }
    
    }
    
    return self;
}

-(NSString *) getDesc
{
    NSString *desc = @"";
    
    if (self.gender)
    {
        desc = self.gender;
    }
    
    if (self.age)
    {
        if ([desc length] > 0)
            desc = [desc stringByAppendingFormat:@", %ld ans", (long)self.age];
        else
            desc = [desc stringByAppendingFormat:@"%ld ans", (long)self.age];
    }
    
    return desc;
}

-(NSString *) getPoints
{
    NSString *desc = @"";
    
    if (self.points)
    {
        desc = [desc stringByAppendingFormat:@"%@ points", self.points];
    }
    
    return desc;
}

-(NSString *) oneLineAddress
{
    return [self.adresse stringByAppendingFormat:@" %@",self.ville];
}

-(NSString *) distanceString
{
    if (self.distance < 1)
    {
        return [@"à " stringByAppendingFormat:@" %im", (int)(self.distance * 1000)];
    }
    
    return [@"à " stringByAppendingFormat:@" %.01fkm", self.distance];
}

-(NSString *) sportJson
{
    NSMutableArray *sportsId = [NSMutableArray array];
    
    for (Sport *sport in self.categories)
    {
        [sportsId addObject:sport.sportId];
    }
    
    NSError* error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:sportsId options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}

- (UIImage *) icon
{
    if (self.typeEtab == 1 || self.typeEtab == 2)
    {
        return [UIImage imageNamed:@"barType"];
    }
    else if (self.typeEtab == 3)
    {
        return [UIImage imageNamed:@"restoType"];
    }
    
    return [UIImage imageNamed:@"loisirType"];
}

- (NSString *) typeLabel
{
    if (self.typeEtab == 1 || self.typeEtab == 2)
    {
        return  @"Bar / Pub";
    }
    else if (self.typeEtab == 3)
    {
        return @"Restaurant";
    }
    
    return @"Centre de loisirs";
}


- (UIImage *) header
{
    if (self.typeEtab == 1 || self.typeEtab == 2)
    {
        return [UIImage imageNamed:@"barHeader"];
    }
    else if (self.typeEtab == 3)
    {
        return [UIImage imageNamed:@"restoHeader"];
    }
    
    return [UIImage imageNamed:@"loisirHeader"];
}

- (UIImage *) bigHeader
{
    if (self.typeEtab == 1 || self.typeEtab == 2)
    {
        return [UIImage imageNamed:@"barBigHeader"];
    }
    else if (self.typeEtab == 3)
    {
        return [UIImage imageNamed:@"restoBigHeader"];
    }
    
    return [UIImage imageNamed:@"loisirBigHeader"];
}

@end
