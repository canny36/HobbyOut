//
//  ParticipateService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 04/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@protocol ParticipateServiceDelegate;

@interface ParticipateService : AbstractService

@property (nonatomic) id<ParticipateServiceDelegate> delegate;

-(id) initWithDelegate:(id<ParticipateServiceDelegate>) delegate;

@end

@protocol ParticipateServiceDelegate

- (void) participate:(ParticipateService*)participateService status:(NSInteger) status;


@end