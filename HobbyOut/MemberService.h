//
//  MemberService.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 10/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@protocol MemberServiceDelegate;

@interface MemberService : AbstractService

@property (nonatomic) id<MemberServiceDelegate> delegate;

-(id) initWithDelegate:(id<MemberServiceDelegate>) delegate;

@end

@protocol MemberServiceDelegate

- (void) memberRetreved:(MemberService*)memberService andMemberData:(NSDictionary *)memberData;


@end
