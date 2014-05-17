//
//  SearchViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 30/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingsService.h"
#import "TrackedViewController.h"

@interface SearchViewController : TrackedViewController

@property(nonatomic) UISearchBar *searchBar;

@property(nonatomic) MeetingsService *meetingsServices;

@end
