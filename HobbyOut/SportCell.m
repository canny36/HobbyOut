//
//  SportCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 06/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "SportCell.h"
#import "AppStyle.h"

@implementation SportCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sportRenderer.png"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sportRenderer.png"]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.sportIcone = [[UIImageView alloc] initWithFrame:CGRectMake(27, 12, 45, 45)];

        [self addSubview:self.sportIcone];
        
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 85, 40)];
        [AppStyle sportNameLabel:self.name];
        [self addSubview:self.name];
        
        
        
        self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, 90 * M_PI / 180.0);
        
    }
    return self;
}

-(void) displaySport:(Sport *) sport
{
    self.name.text = sport.name;
    
    self.sportIcone.image = sport.icone;
}

@end
