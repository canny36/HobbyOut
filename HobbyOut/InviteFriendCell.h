//
//  InviteFriendCell.h
//  HobbyOut
//
//  Created by Srinivas on 16/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface InviteFriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic)BOOL checked;

-(void)check;
-(void)refreshView;
    
@end
