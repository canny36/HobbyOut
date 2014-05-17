//
//  BigNewsCell.h
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 13/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Invitation.h"
#import "FriendRequest.h"

@interface BigNewsCell : UITableViewCell

@property(nonatomic) UIButton *acceptButton;
@property(nonatomic) UIButton *declineButton;
@property(nonatomic) Invitation *invitation;
@property(nonatomic) FriendRequest *friendRequest;
@property(nonatomic) UIImageView *avatarView;

@property(nonatomic) UILabel *eventLabel;


-(void) displayRequest:(Invitation *)invitation;
-(void) displayFriendRequest:(FriendRequest *) friendRequest;

@end
