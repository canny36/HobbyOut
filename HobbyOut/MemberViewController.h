//
//  MemberViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 05/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"

#import "MemberService.h"
#import "UpdateUserService.h"

#import "TrackedViewController.h"

@interface MemberViewController : TrackedViewController

@property(nonatomic) Member *member;

@property(nonatomic) NSString *memberId;

@property(nonatomic) MemberService *memberService;
@property(nonatomic) UpdateUserService *updateUserService;

-(id) initWithMemberId:(NSString *) memberId;


@end
