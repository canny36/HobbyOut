//
//  Meeting.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 29/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "Meeting.h"
#import "MemberMeeting.h"
#import "OtherMeeting.h"
#import "TribuneMeeting.h"
#import "Participant.h"
#import "Member.h"
#import "UserDefaultManager.h"


@implementation Meeting


-(id) initWithDictionary:(NSDictionary *)data
{
    self = [super init];
    if (self)
    {
        self.meetingId = [data objectForKey:@"meeting_id"];
        self.memberId = [data objectForKey:@"member_id"];
        
        self.eventName = [data objectForKey:@"event_name"];
        self.tribuneId = [data objectForKey:@"id_tribune"];
        self.fullpath = [data objectForKey:@"fullpath"];
        
        self.isTribune = [[data objectForKey:@"is_tribune"] boolValue];
        self.typeLieu = [[data objectForKey:@"type_lieu"] integerValue];
        self.lieu = [data objectForKey:@"lieu"];
      
        if ([data objectForKey:@"isInvitation"] && [data objectForKey:@"isInvitation"] != [NSNull null])
            self.isInvitation = [[data objectForKey:@"isInvitation"] boolValue];
        
        if ([data objectForKey:@"participant_status"] != [NSNull null])
            self.participantStatus = [[data objectForKey:@"participant_status"] integerValue];
        
        if ([data objectForKey:@"diffuseur_icone"])
            self.broadcasterPath = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"diffuseur_icone"]];
        
        if ([data objectForKey:@"avatar"])
             self.avatar = [@"http://www.hobbyout.com/" stringByAppendingString:[data objectForKey:@"avatar"]];
        
        if ([data objectForKey:@"type_etablissement"] != [NSNull null])
            self.typeEtab = [[data objectForKey:@"type_etablissement"] integerValue];
        
        if ([data objectForKey:@"etablissement"] != [NSNull null])
            self.etablissement = [data objectForKey:@"etablissement"];
        
        self.hour = [[data objectForKey:@"date_start"] substringWithRange:NSMakeRange(11, 5)];
        self.hour = [self.hour stringByReplacingOccurrencesOfString:@":" withString:@"H"];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"fr_FR"];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date = [dateFormat dateFromString:[data objectForKey:@"date_start"]];
        [dateFormat setDateFormat:@"dd MMMM yyyy"];
        self.fullDate = [[dateFormat stringFromDate:date] uppercaseString];
        [dateFormat setDateFormat:@"EEEE dd MMMM yyyy"];
        self.fullWithDayDate = [[dateFormat stringFromDate:date] lowercaseString];
        
        if ([data objectForKey:@"distance"] != [NSNull null] )
            self.distance = [[data objectForKey:@"distance"] floatValue];
        
        self.adresse = [data objectForKey:@"adresse"];
        self.ville = [data objectForKey:@"ville"];
        self.postcode = [data objectForKey:@"postcode"];
        
        self.latitude = [[data objectForKey:@"lat"] floatValue];
        self.longitude = [[data objectForKey:@"lng"] floatValue];
        
        _coordinate.latitude = self.latitude ;
        _coordinate.longitude = self.longitude;
        
        if ([data objectForKey:@"nb_participant"] != [NSNull null])
            self.nbParticipant = [[data objectForKey:@"nb_participant"] integerValue];
        
        if ([data objectForKey:@"max_participant"] != [NSNull null])
            self.maxParticipant = [[data objectForKey:@"max_participant"] integerValue];
        else
            self.maxParticipant = -1;
        
        self.participants = [NSMutableArray array];
        if ([data objectForKey:@"participants"] != [NSNull null])
        {
            for (NSDictionary *participantData in [data objectForKey:@"participants"])
            {
                [self.participants addObject:[[Participant alloc] initWithDictionary:participantData]];
            }
            
        }
    }
    
    return self;
}

-(NSString *) getName
{
    return nil;
}

-(NSInteger) getStatus
{
    Member *user = [UserDefaultManager getUser];
    
    if ([self.memberId isEqualToString:user.memberId])
        return 10;
    
    if (self.participantStatus == -1 || self.participantStatus == 1 || self.participantStatus == 2)
    {
        return self.participantStatus;
    }
    
    if ((self.maxParticipant != -1) && (self.maxParticipant <= self.nbParticipant) )
    {
        return 3;
    }
    
    return 0;
}

-(NSString *) getStatusLabel
{
    if ([self getStatus] == 1)
    {
        if (self.isInvitation)
            return @"INVITATION REÇUE";
        return @"DEMANDE ENVOYÉE";
    }

    if ([self getStatus] == 2)
    {
        return @"INSCRIT";
    }

    if ([self getStatus] == -1)
    {
        if (self.isInvitation)
            return @"INVITATION REFUSÉE";
        
        return @"DEMANDE REFUSÉE";
    }
    
    if ([self getStatus] == 3)
    {
        return @"COMPLET";
    }
    
    if ([self getStatus] == 10)
    {
        return @"J'ORGANISE";
    }

    return @"Non inscrit";
}

-(NSString *) getNbPlace
{
    if (self.maxParticipant == - 1)
        return @"Places illimitées";
    
    NSInteger placeFree = self.maxParticipant - [self.participants count];
    
    if (placeFree == 1)
        return @"Plus qu'une place";
    
    return [NSString stringWithFormat:@"%u places restantes", placeFree];
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

+(Meeting *) getMeetingFromDictionary:(NSDictionary *)data
{
    if ([data objectForKey:@"type_lieu"] == [NSNull null] ||
        [[data objectForKey:@"type_lieu"] integerValue] == 1)
    {
        return [[MemberMeeting alloc] initWithDictionary:data];
    }
    else if ([[data objectForKey:@"type_lieu"] integerValue] == 2)
    {
        return [[TribuneMeeting alloc] initWithDictionary:data];
    }
    
    
    return [[OtherMeeting alloc] initWithDictionary:data];
}

- (UIImage *) icone
{
    if (![self.sport isEqualToString:@"Tous les sports"])
    {
        NSArray *path = [self.fullpath componentsSeparatedByString:@"|"];
        NSString *sport = [[path objectAtIndex:0] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        
        NSString *fileName = [[NSString stringWithFormat:@"%@Icon", sport] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"-/-" withString:@"-"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"'" withString:@"-"];
    
        return [UIImage imageNamed:fileName];
    }
    
    return [UIImage imageNamed:@"allSportsIcon"];
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
    else if (self.typeEtab == 4)
    {
        return [UIImage imageNamed:@"loisirHeader"];
    }
    
    return [UIImage imageNamed:@"autreHeader"];
}

-(UIImage *) simpleHeader
{
    if (self.typeEtab == 1 || self.typeEtab == 2)
    {
        return [UIImage imageNamed:@"barSimple"];
    }
    else if (self.typeEtab == 3)
    {
        return [UIImage imageNamed:@"restoSimple"];
    }
    else if (self.typeEtab == 4)
    {
        return [UIImage imageNamed:@"loisirSimple"];
    }
    
    return [UIImage imageNamed:@"autreSimple"];
}

- (NSString *) sport
{
    if (self.fullpath && ![self.fullpath  isEqual:[NSNull null]])
    {
        NSArray *path = [self.fullpath componentsSeparatedByString:@"|"];
        return[path objectAtIndex:0] ;
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
