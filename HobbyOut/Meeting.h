//
//  Meeting.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 29/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MapKit/MapKit.h>

@interface Meeting : NSObject

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property(nonatomic) NSString *meetingId;
@property(nonatomic) NSString *memberId;
@property(nonatomic) NSString *tribuneId;
@property(nonatomic) NSString *avatar;

@property(nonatomic) float distance;

@property(nonatomic) BOOL isTribune;
@property(nonatomic) BOOL isInvitation;


@property(nonatomic) float latitude;
@property(nonatomic) float longitude;

@property(nonatomic) NSString *adresse;
@property(nonatomic) NSString *postcode;
@property(nonatomic) NSString *ville;
@property(nonatomic) NSString *lieu;

@property(nonatomic) NSInteger maxParticipant;
@property(nonatomic) NSInteger nbParticipant;
@property(nonatomic) NSInteger typeLieu;
@property(nonatomic) NSInteger typeEtab;

@property(nonatomic) NSString *eventName;
@property(nonatomic) NSString *hour;
@property(nonatomic) NSString *fullDate;
@property(nonatomic) NSString *fullWithDayDate;
@property(nonatomic) NSString *broadcasterPath;
@property(nonatomic) NSInteger participantStatus;
@property(nonatomic) NSString *fullpath;
@property(nonatomic) NSString *etablissement;

@property(nonatomic) NSMutableArray *participants;



-(id) initWithDictionary:(NSDictionary *)data;

- (NSString *) getName;
- (NSString *) getStatusLabel;
- (NSInteger) getStatus;
- (NSString *) getNbPlace;
- (NSString *) oneLineAddress;
- (NSString *) distanceString;
- (NSString *) category;
- (NSString *) sport;


- (UIImage *) icone;
- (UIImage *) header;
- (UIImage *) simpleHeader;




+(Meeting *) getMeetingFromDictionary:(NSDictionary *)data;

@end
