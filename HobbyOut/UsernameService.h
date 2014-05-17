//
//  UsernameService.h
//  HobbyOut
//
//  Created by Srinivas on 06/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@class UsernameService;

@protocol UsernameServiceDelegate

- (void) usernameSucess:(UsernameService*)loginService;

- (void) usernameFail:(UsernameService*)loginService message:(NSString *)message;

@end

@interface UsernameService : AbstractService

@property (nonatomic) id<UsernameServiceDelegate> delegate;

-(id) initWithDelegate:(id<UsernameServiceDelegate>) delegate;


@end
