//
//  ParticipantCollectionCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Participant.h"

@interface ParticipantCollectionCell : UICollectionViewCell

@property(nonatomic) UIImageView *avatarImageView;
@property(nonatomic) UILabel *nameLabel;

-(void) displayParticipant:(Participant *)participant;

@end
