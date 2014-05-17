//
//  FeedView.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAbsolutView.h"

@interface FeedView : UIAbsolutView

@property(nonatomic) UITableView *tableView;

@property(nonatomic) UIAbsolutView *noDataFrame;

@end
