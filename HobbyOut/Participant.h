//
//  Participant.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Participant : NSObject

@property(nonatomic) NSString *userId;
@property(nonatomic) NSString *avatarUrl;
@property(nonatomic) NSString *name;

-(id) initWithDictionary:(NSDictionary *)data;
-(id) initWithName:(NSString *)name userId:(NSString *) userId andAvatarUrl:(NSString *) avatarUrl;

@end
