//
//  AddFriendService.h
//  HobbyOut
//
//  Created by Srinivas on 30/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "AbstractService.h"
typedef void (^onSuccess)(NSDictionary *response);

@interface AddFriendService : AbstractService
-(id) initWithDelegate:(onSuccess) successBlock;
@property(nonatomic,copy)onSuccess success;
@end
