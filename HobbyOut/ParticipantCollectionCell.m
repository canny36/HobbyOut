//
//  ParticipantCollectionCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "ParticipantCollectionCell.h"

#import "AppStyle.h"
#import "UIImageView+WebCache.h"

@implementation ParticipantCollectionCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 62, 62)];
        [AppStyle particpantPhotoFrame:self.avatarImageView];
        [self addSubview:self.avatarImageView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 62, 62, 18)];
        [AppStyle participantNameLabel:self.nameLabel];

        [self addSubview:self.nameLabel];
    }
    
    return self;
}

-(void) displayParticipant:(Participant *)participant
{
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:participant.avatarUrl]];
    self.nameLabel.text = participant.name;
}


@end
