//
//  ParticipantPopUpViewController.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 20/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Participant.h"

@protocol ParticipantPopUpDelegate

-(void) didSelectParticipant:(Participant *) participant;

@end

@interface ParticipantPopUpViewController : UIViewController

@property(nonatomic) NSArray *participants;
@property(nonatomic) id<ParticipantPopUpDelegate> delegate;

- (void) refresh;

@end




