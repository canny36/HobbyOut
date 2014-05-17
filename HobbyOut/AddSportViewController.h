//
//  AddSportViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 17/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SportService.h"
#import "Sport.h"

@protocol AddSportDelegate

-(void) sportSelected:(Sport *) sport;

@end

@interface AddSportViewController : UITableViewController

@property(nonatomic) id<AddSportDelegate> delegate;
@property(nonatomic) SportService *sportService;
@property(nonatomic) NSArray *sportToFilter;

@end
