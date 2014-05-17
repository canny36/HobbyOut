//
//  TribuneDetailsViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 24/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Member.h"
#import "MemberService.h"

#import "TrackedViewController.h"

@interface TribuneDetailsViewController : TrackedViewController

@property(nonatomic) Member *member;
@property(nonatomic) MemberService *memberservice;

-(id) initWithMemberId:(NSString *) memberId;

@end
