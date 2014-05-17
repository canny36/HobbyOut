//
//  LoginService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 23/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractService.h"

@protocol LoginServiceDelegate;

@interface LoginService : AbstractService

@property (nonatomic) id<LoginServiceDelegate> delegate;

-(id) initWithDelegate:(id<LoginServiceDelegate>) delegate;

@end

@protocol LoginServiceDelegate

- (void) loginSucess:(LoginService*)loginService;

- (void) loginFail:(LoginService*)loginService message:(NSString *)message;

@end
