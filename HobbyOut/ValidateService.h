//
//  ValidateService.h
//  HobbyOut
//
//  Created by Srinivas on 01/05/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@interface ValidateService : AbstractService

-(id) initWithDelegate:(void(^)(NSDictionary *response))onsuccess;
@property(nonatomic,copy)void (^onSuccess)(NSDictionary *response);

@end
