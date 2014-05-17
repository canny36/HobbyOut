//
//  RegisterService.h
//  HobbyOut
//
//  Created by Srinivas on 06/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "AbstractService.h"
@class RegisterService;

@protocol RegisterServiceDelegate

- (void) registerSucess:(RegisterService*)loginService response:(NSDictionary*)response;

- (void) registerFail:(RegisterService*)loginService message:(NSString *)message;

@end

@interface RegisterService : AbstractService
@property (nonatomic) int tag;
@property (nonatomic) id<RegisterServiceDelegate> delegate;
-(id) initWithDelegate:(id<RegisterServiceDelegate>) delegate;
-(id) initWithRegisterDelegate:(id<RegisterServiceDelegate>) delegate;
@end
