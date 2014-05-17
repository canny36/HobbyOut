//
//  FriendRequest.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 13/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendRequest : NSObject

@property(nonatomic) NSString *memberId;
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *avatarUrl;

-(id) initWithDictionary:(NSDictionary *)data;

@end
