//
//  Sport.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 06/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sport : NSObject

@property(nonatomic) NSString *sportId;
@property(nonatomic) NSString *name;


-(id) initWithDictionary:(NSDictionary *)data;

- (UIImage *) icone;

+ (NSArray *) sportsFormDataArray:(NSArray *) data;
+ (Sport *) allSport;
+ (UIImage *) headerFor:(NSString *) sportName;

@end
