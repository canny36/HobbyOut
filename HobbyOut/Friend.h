//
//  Friend.h
//  HobbyOut
//
//  Created by Srinivas on 15/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Friend : NSObject

@property(nonatomic,strong)NSString *avatar;
@property(nonatomic,strong)NSString *distance;
@property(nonatomic,strong)NSString *friendId;
@property(nonatomic,strong)NSString *username ;

-(id)initWithDictionary:(NSDictionary*)data;

@end
