//
//  SportCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 06/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Sport.h"

@interface SportCell : UITableViewCell

@property(nonatomic) UILabel *name;
@property(nonatomic) UIImageView *sportIcone;

-(void) displaySport:(Sport *) sport;

@end
