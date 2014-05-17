//
//  InviteFriendCell.m
//  HobbyOut
//
//  Created by Srinivas on 16/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "InviteFriendCell.h"
#import "AppStyle.h"

@interface InviteFriendCell()



@end

@implementation InviteFriendCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void)check{
    _checked = !_checked;
    [self refreshView];
}

-(void)refreshView{
    NSString *checkImageName = _checked ? @"checkbox-on.png":@"checkbox-off.png";
    UIColor *labelColor = !_checked ? [UIColor colorWithRed:(243.0/255) green:(122.0/255) blue:(92.0/255) alpha:1]:[UIColor colorWithRed:(174.0/255) green:(173.0/255) blue:(171.0/255) alpha:1];
    _checkboxImageView.image = [UIImage imageNamed:checkImageName];
    _nameLabel.textColor = labelColor;
    if (_checked) {
        _avatarImageView.alpha = 1.0;
        [AppStyle meetingNbParticipantLabel:_nameLabel];
    }else{
        _avatarImageView.alpha = 0.5;
         [AppStyle meetingDetailsNameLabel:_nameLabel];
    }
    
}

@end
