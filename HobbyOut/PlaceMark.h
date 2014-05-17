//
//  OptionalPlaceMark.h
//  Artyday
//
//  Created by Frédéric DE MATOS on 06/02/13.
//  Copyright (c) 2013 Frianbiz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Meeting.h"
#import "Member.h"

@interface PlaceMark : NSObject<MKAnnotation>

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *pinMapImageName;
@property (nonatomic) CLLocationCoordinate2D coordinate;

-(id) initWithMeeting:(Meeting *)meeting;
-(id) initWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle andCoordinate:(CLLocationCoordinate2D)coordinate;

-(id) initWithMember:(Member *)member;


@end
