//
//  OptionalPlaceMark.m
//  Artyday
//
//  Created by Frédéric DE MATOS on 06/02/13.
//  Copyright (c) 2013 Frianbiz. All rights reserved.
//

#import "PlaceMark.h"

@implementation PlaceMark


-(id) initWithTitle:(NSString *)title andSubTitle:(NSString *)subTitle andCoordinate:(CLLocationCoordinate2D)coordinate;
{
    self = [super init];
    
    if (self)
    {
        self.title = title;
        self.address = subTitle;
        self.pinMapImageName = @"mapPin.png";
    }
    
    return self;
    
}

-(id) initWithMeeting:(Meeting *)meeting;

{
    self = [super init];
    
    if (self)
    {
        self.title = [meeting getName];
        self.address = [meeting oneLineAddress];
        self.pinMapImageName = @"mapPin.png";
        self.coordinate = meeting.coordinate;
    }
    
    return self;
    
}


-(id) initWithMember:(Member *)member;

{
    self = [super init];
    
    if (self)
    {
        self.title = member.username;
        self.address = [member oneLineAddress];
        self.pinMapImageName = @"mapPin.png";
        self.coordinate = member.coordinate;
    }
    
    return self;
    
}





- (NSString *)subtitle
{
    return self.address;
}



@end
