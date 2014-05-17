//
//  Meetings.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 11/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "AbstractService.h"

@protocol MeetingsServiceDelegate;

@interface MeetingsService : AbstractService

@property (nonatomic) id<MeetingsServiceDelegate> delegate;

-(id) initWithDelegate:(id<MeetingsServiceDelegate>) delegate;

@end

@protocol MeetingsServiceDelegate

- (void) meetingsRetrieved:(MeetingsService*) service meetingByCategory:(NSDictionary *) meetingByCategory andCategoryArray:(NSArray *)categoryArray;

@end
