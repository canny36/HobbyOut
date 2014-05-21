//
//  Sport.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 06/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "Sport.h"

@implementation Sport

-(id) initWithDictionary:(NSDictionary *)data
{
    NSLog(@"Sport : %@",data.description);
    self = [super init];
    
    if (self)
    {
        self.sportId = [data objectForKey:@"id"];
        if (self.sportId == nil) {
            self.sportId = @"";
        }
        
        if ([data objectForKey:@"name"])
            self.name = [data objectForKey:@"name"];
        else
            self.name = [data objectForKey:@"title"];
    }
    
    return self;
}


- (UIImage *) icone
{
    NSString *fileName = [[NSString stringWithFormat:@"%@Cat", self.name] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    fileName = [fileName stringByReplacingOccurrencesOfString:@"-/-" withString:@"-"];
    fileName = [fileName stringByReplacingOccurrencesOfString:@"'" withString:@"-"];
    
    return [UIImage imageNamed:fileName];
}

+ (NSArray *) sportsFormDataArray:(NSArray *) data
{
    NSMutableArray *sports = [NSMutableArray array];
    
    for (NSDictionary *sportData in data)
    {
        [sports addObject:[[Sport alloc] initWithDictionary:sportData]];
    }
    
    return sports;
}

+ (Sport *) allSport
{
    Sport *allSport = [[Sport alloc] init];
    allSport.name = @"Tous les sports";
    return allSport;
}

+ (UIImage *) headerFor:(NSString *) sportName
{
    if (![sportName isEqualToString:@"Tous les sports"])
    {
        NSString *fileName = [[NSString stringWithFormat:@"%@Section", sportName] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"-/-" withString:@"-"];
        fileName = [fileName stringByReplacingOccurrencesOfString:@"'" withString:@"-"];
    
        return [UIImage imageNamed:fileName];
    }
    
     return [UIImage imageNamed:@"allSportsSection"];
}

@end
