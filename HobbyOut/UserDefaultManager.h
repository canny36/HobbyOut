//
//  UserDefaultManager.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 24/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Member.h"


#define SESSION_TOKEN @"sessionToken"
#define USER @"userKey"

@interface UserDefaultManager : NSObject

+(void) setSessionToken:(NSString *) token;
+(NSString *) getSessionToken;

+(void) setUser:(NSDictionary *) userData;
+(Member *) getUser;

+(void) logout;


@end
