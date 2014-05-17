//
//  TvCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TvCell.h"

#import "AppStyle.h"
#import "UIColor+category.h"

#import "UIImageView+WebCache.h"

@implementation TvCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvRenderer"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tvRenderer"]];

        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 27, 50, 20)];
        [AppStyle eventWhiteLabel:self.timeLabel];
       
        [self addSubview:self.timeLabel];
        
        self.competitionLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, 28, 150, 20)];
        [AppStyle eventGreyLabel:self.competitionLabel];
        [self addSubview:self.competitionLabel];
        
        self.broadcasterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(255, 15, 35, 26)];
        self.broadcasterImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.broadcasterImageView];

        
        self.eventNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 48, 250, 45)];
        [AppStyle eventNameLabel:self.eventNameLabel];
        [self addSubview:self.eventNameLabel];
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 95, 250, 20)];
        [AppStyle eventStatusLabel:self.statusLabel];
        [self addSubview:self.statusLabel];
        
        self.sportIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 15, 27, 27)];
       
        [self addSubview:self.sportIconImageView];
        
    }
    return self;
}

-(void) displayTvBroadcast:(TvBroadcast *) tvBroadcast
{
    self.competitionLabel.text = tvBroadcast.category;
    self.timeLabel.text = tvBroadcast.hour;
    self.eventNameLabel.text = tvBroadcast.name;
    self.sportIconImageView.image = tvBroadcast.icone;
    [self.broadcasterImageView setImageWithURL:[NSURL URLWithString:tvBroadcast.broadcasterPath]];
    
     if ([tvBroadcast.meetings count] == 0)
     {
         self.statusLabel.text = @"Aucun événement prévu";
         [AppStyle eventStatusLabel:self.statusLabel];
     }
     else
     {
        self.statusLabel.text = @"Voir les événements";
        self.statusLabel.textColor = [UIColor colorWithHexString:@"ff682a"];
     }

}




@end
