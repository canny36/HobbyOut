//
//  InviteFriendService.h
//  HobbyOut
//
//  Created by Srinivas on 26/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@interface InviteFriendService : AbstractService

@property(nonatomic,copy)void (^onSuccess)(NSDictionary* response);
@property(nonatomic,copy)void (^onFail)(NSString* error);

@end
