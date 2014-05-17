//
//  TvBroadcast.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TvBroadcast : NSObject

@property(nonatomic) NSString *id;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *hour;
@property(nonatomic) NSString *fullDate;
@property(nonatomic) NSString *fullWithDayDate;
@property(nonatomic) NSString *broadcasterPath;
@property(nonatomic) NSMutableArray *meetings;
@property(nonatomic) NSMutableArray *tribunes;

@property(nonatomic) NSString *fullpath;

@property(nonatomic) NSDictionary *data;

- (id) initWithDictionary:(NSDictionary *)data;

- (UIImage *) icone;
- (NSString *) category;
- (NSString *) sport;

@end
