//
//  Invitation.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 13/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meeting.h"

@interface Invitation : NSObject


@property(nonatomic) NSString *eventName;
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *avatarUrl;
@property(nonatomic) NSString *memberId;
@property(nonatomic) NSString *otherMemberId;

@property(nonatomic) NSString *eventCategory;
@property(nonatomic) NSString *meetingTitle;
@property(nonatomic) NSString *meetingId;
@property(nonatomic) Meeting *meeting;

@property(nonatomic) NSString *hour;
@property(nonatomic) NSString *fullDate;
@property(nonatomic) NSString *fullWithDayDate;


-(id) initWithDictionary:(NSDictionary *)data;


@end
