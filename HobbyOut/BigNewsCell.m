//
//  BigNewsCell.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 13/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "BigNewsCell.h"
#import "AppStyle.h"
#import "Invitation.h"
#import "ParticipationRequest.h"

#import "UIImageView+WebCache.h"

#import "UIAbsolutView.h"

@implementation BigNewsCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedRenderer"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"feedRenderer"]];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [AppStyle friendRequest:self.textLabel];
        
        self.avatarView = [[UIImageView alloc] init];
        self.avatarView.userInteractionEnabled = YES;
        [self addSubview:self.avatarView];
        
        [AppStyle particpantPhotoFrame:_avatarView];
        
        self.eventLabel = [[UILabel alloc]init];
        self.eventLabel.userInteractionEnabled = YES;
        [AppStyle requestEventName:self.eventLabel];
        [self addSubview:self.eventLabel];
        
        UIAbsolutView *buttonsContainer = [[UIAbsolutView alloc] initWithFrame:CGRectMake(0, 120, self.frame.size.width, 38)];
        [self addSubview:buttonsContainer];
        
        self.acceptButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 148, 38)];
        [self.acceptButton setImage:[UIImage imageNamed:@"confirmFeedButton"] forState:UIControlStateNormal];
        [buttonsContainer addSubview:self.acceptButton toTop:@0 right:@25 bottom:nil left:nil];
        
        self.declineButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 122, 38)];
        [self.declineButton setImage:[UIImage imageNamed:@"cancelFeedButton"] forState:UIControlStateNormal];
        [buttonsContainer addSubview:self.declineButton toTop:@0 right:nil bottom:nil left:@10];
        
        
    }
    return self;
}

-(void) displayFriendRequest:(FriendRequest *)friendRequest
{
    self.friendRequest = friendRequest;
    self.invitation = nil;
    
    
    NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIFont fontWithName:@"Roboto-Medium" size:16], NSFontAttributeName, nil];
    
  
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:friendRequest.username attributes:subAttrs];
    
     _eventLabel.text = @"souhaite faire partie de tes amis";
    self.textLabel.attributedText = attributedText;
    
    [_avatarView setImageWithURL:[NSURL URLWithString:friendRequest.avatarUrl]];
}

-(void) displayRequest:(Invitation *)invitation
{
    self.invitation = invitation;
    self.friendRequest = nil;
    
    NSMutableAttributedString *attributedText;
    NSDictionary *subAttrs = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIFont fontWithName:@"Roboto-Medium" size:12], NSFontAttributeName, nil];
    NSRange range;
    NSString *string;
    
    
    if ([invitation isKindOfClass:[ParticipationRequest class]])
    {
        string = [NSString stringWithFormat:@"%@ souhaite participer\nle %@ à %@", invitation.username, invitation.fullWithDayDate, invitation.hour];
        range = [string rangeOfString:@"souhaite participer"];
        
        attributedText = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedText setAttributes:subAttrs range:range];
        
        self.textLabel.attributedText = attributedText;
    }
    else
    {
        string = [NSString stringWithFormat:@"%@ t'invite\nle %@ à %@", invitation.username, invitation.fullWithDayDate, invitation.hour];
        range = [string rangeOfString:@"invite"];
        
        attributedText = [[NSMutableAttributedString alloc] initWithString:string];
        [attributedText setAttributes:subAttrs range:range];
        
        
        self.textLabel.attributedText = attributedText;
        
    }
    
    _eventLabel.text = invitation.eventName;
    
    [_avatarView setImageWithURL:[NSURL URLWithString:invitation.avatarUrl]];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.frame = CGRectMake(65, 10, self.frame.size.width - 70, 55);
    _avatarView.frame = CGRectMake(7, 12, 50, 50);
    
    _eventLabel.frame = CGRectMake(10, 65, self.frame.size.width - 20, 50);
}



@end
