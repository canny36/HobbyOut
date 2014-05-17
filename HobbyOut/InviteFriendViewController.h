//
//  InviteFriendViewController.h
//  HobbyOut
//
//  Created by Srinivas on 14/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZFormSheetController.h"
#import "Meeting.h"

@interface InviteFriendViewController : UIViewController
@property(nonatomic,strong)Meeting *meeting;
@property(nonatomic,copy)void (^dismissBlock)(NSString *message);
@property(nonatomic,copy)void (^inviteFriends)(NSDictionary *requestDict);
@end
