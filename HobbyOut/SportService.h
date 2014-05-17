//
//  SportService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 17/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@protocol SportServiceDelegate

- (void) sportRetrieved:(NSArray *) sports;

@end

@interface SportService : AbstractService

@property(nonatomic) id<SportServiceDelegate> delegate;
-(id) initWithDelegate:(id<SportServiceDelegate>) delegate;

@end
