//
//  Member.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 04/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Member : NSObject


@property (nonatomic) CLLocationCoordinate2D coordinate;

@property(nonatomic) NSString *memberId;
@property(nonatomic) NSString *name;
@property(nonatomic) NSString *etablissement;
@property(nonatomic) NSString *username;
@property(nonatomic) NSString *gender;
@property(nonatomic) NSInteger age;
@property(nonatomic) NSString *points;
@property(nonatomic) NSString *badge;
@property(nonatomic) NSMutableArray *categories;
@property(nonatomic) NSMutableArray *meetingsOrganising;
@property(nonatomic) NSMutableArray *meetingsParticipating;
@property(nonatomic) NSString *avatarUrl;

@property(nonatomic) NSString *adresse;
@property(nonatomic) NSString *postcode;
@property(nonatomic) NSString *ville;

@property(nonatomic) NSInteger nbTV;
@property(nonatomic) NSInteger typeEtab;
@property(nonatomic) NSInteger friendStatus;

@property(nonatomic) float distance;

@property(nonatomic) NSMutableArray *tvBroadcasts;
@property(nonatomic) NSMutableArray *friends;

-(id) initWithDictionary:(NSDictionary *)data;

-(NSString *) getDesc;
-(NSString *) getPoints;
-(NSString *) oneLineAddress;
-(NSString *) distanceString;

-(NSString *) sportJson;

-(UIImage *) header;
-(UIImage *) icon;
- (UIImage *) bigHeader;

- (NSString *) typeLabel;



@end
