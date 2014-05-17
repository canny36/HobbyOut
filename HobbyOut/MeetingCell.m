//
//  MeetingCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 28/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MeetingCell.h"
#import "AppStyle.h"
#import "UIColor+category.h"

#import "UIImageView+WebCache.h"



@implementation MeetingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meetingTribune.png"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meetingTribune.png"]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.header = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barSimple"]];
        self.header.frame = CGRectMake(10, 2, 299, 56);
        self.header.contentMode = UIViewContentModeScaleAspectFill;
        self.header.clipsToBounds = YES;
        [self addSubview:self.header];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(18, 20, 280, 35)];
        self.nameLabel.userInteractionEnabled = TRUE;
        [AppStyle meetingNameLabel:self.nameLabel];
        [self addSubview:self.nameLabel];
        
        self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 75, 25)];
        [AppStyle meetingDistanceLabel:self.distanceLabel];
        [self addSubview:self.distanceLabel];
        
        self.adresseLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 60, 225, 25)];
        [AppStyle meetingAdressLabel:self.adresseLabel];
        [self addSubview:self.adresseLabel];
        
        self.cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 75, 225, 25)];
        [AppStyle meetingAdressLabel:self.cityLabel];
        [self addSubview:self.cityLabel];
        
        self.mapButton = [[UIButton alloc] initWithFrame:CGRectMake(270, 40, 30, 34)];
        [self.mapButton setImage:[UIImage imageNamed:@"geolocButton.png"] forState:UIControlStateNormal];
        [self addSubview:self.mapButton];
        
        self.participateButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 105, 299, 28)];
        [self.participateButton setImage:[UIImage imageNamed:@"participateButton.png"] forState:UIControlStateNormal];
                self.participateButton.imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:self.participateButton];
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, 300, 29)];
        [AppStyle meetingStatusLabel:self.statusLabel];
        [self addSubview:self.statusLabel];
               
    }
    return self;
}

-(void) displayMeeting:(Meeting *) meeting
{
    self.statusLabel.hidden = YES;
    self.participateButton.hidden = YES;
    
    self.meeting = meeting;
    self.nameLabel.text = [meeting getName];
    self.cityLabel.text = [meeting.postcode stringByAppendingFormat:@" %@", meeting.ville];
    self.adresseLabel.text = meeting.adresse;
    self.distanceLabel.text = meeting.distanceString;
    
    if (self.meeting.typeLieu == 1)
    {
        [self.header setImageWithURL:[NSURL URLWithString:self.meeting.avatar]];
        self.header.frame = CGRectMake(23, 14, 54, 44);
        self.nameLabel.frame = CGRectMake(88, 20, 210, 35);
        self.nameLabel.textColor = [UIColor colorWithHexString:@"3c3c3c"];
    }
    else
    {
        [self.header setImage:meeting.simpleHeader];
        [AppStyle cancelPhotoFrame:self.header];
        self.header.frame = CGRectMake(10, 2, 299, 56);
        self.nameLabel.frame = CGRectMake(18, 20, 280, 35);
        [AppStyle meetingNameLabel:self.nameLabel];
    }
    
    NSInteger status = [meeting getStatus];
    if (status == 1 || status == 2 || status == -1 || status == 3  || status == 10)
    {
        self.statusLabel.hidden = NO;
        self.statusLabel.text = [meeting getStatusLabel];
    }
    else
    {
        self.participateButton.hidden = NO;
    }
    
}

-(void) refresh
{
    [self displayMeeting:self.meeting];
}


@end
