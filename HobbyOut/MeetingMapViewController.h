//
//  MeetingMapViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 29/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meeting.h"
#import "PlaceMark.h"

#import "TrackedViewController.h"

@interface MeetingMapViewController : TrackedViewController

@property(nonatomic) PlaceMark *placemark;


-(id) initWithTitle:(NSString *) title andPlaceMark:(PlaceMark *) placeMark;

@end
