//
//  InviteFriendViewController.m
//  HobbyOut
//
//  Created by Srinivas on 14/04/14.
//  Copyright (c) 2014 smartfrog. All rights reserved.
//

#import "InviteFriendViewController.h"
#import <FacebookSDK/FacebookSDK.h>
#import "Friend.h"
#import "UserDefaultManager.h"
#import "SDWebImageManager.h"
#import "InviteFriendCell.h"
#import "AppStyle.h"
#import "UIImageView+WebCache.h"
#import "UIView+ShowHide.h"
#import "Member.h"
#import "UserDefaultManager.h"
#import "UIImageView+WebCache.h"
#import "InviteFriendService.h"
#import "MBProgressHUD.h"

@interface InviteFriendViewController ()

@property(nonatomic,strong)NSArray *friends;
@property(nonatomic,strong)NSMutableArray *checkedFriends;
@property (weak, nonatomic) IBOutlet UILabel *meetingDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *meetingTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tvchannelLogoImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet UIView *inviteView;
@property (weak, nonatomic) IBOutlet UIView *friendView;
@property (weak, nonatomic) IBOutlet UIView *confirmView;

@property (weak, nonatomic) IBOutlet UILabel *meetingPlaceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *meetingAddressLabel;

@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;


@property (weak, nonatomic) IBOutlet UIButton *confirmButton;
- (IBAction)confrimButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *inviteButton;
- (IBAction)inviteButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)sendButtonAction:(id)sender;

@end

@implementation InviteFriendViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _friends = [UserDefaultManager getUser].friends;
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView{
    
    self.meetingTitleLabel.text = self.meeting.eventName;
    [AppStyle meetingEventNameLabel:self.meetingTitleLabel];
    self.meetingDateLabel.text = [NSString stringWithFormat:@"%@ - %@",self.meeting.fullDate, self.meeting.hour ];
    [AppStyle meetingDateLabel:self.meetingDateLabel];
    self.locationLabel.text = [self.meeting category];
    [AppStyle eventGreyLabel:self.locationLabel];
    
    Member *member = [UserDefaultManager getUser];
    NSString *placeStr = nil;
    if (!self.meeting.isTribune) {
        if (self.meeting.typeLieu == 3 || self.meeting.typeLieu == 4) {
            placeStr = self.meeting.lieu;
        }else if(self.meeting.typeLieu == 1 || self.meeting.typeLieu == 0){
            placeStr = member.name;
        }
    }else{
         placeStr = self.meeting.etablissement;
    }
    self.meetingPlaceLabel.text = placeStr;
    self.meetingAddressLabel.text =  [NSString stringWithFormat:@"%@ , %@ %@",self.meeting.adresse,self.meeting.postcode,self.meeting.ville];
    
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.meeting.avatar]];
    [self.tvchannelLogoImageView setImageWithURL:[NSURL URLWithString:self.meeting.broadcasterPath]];
    
    _inviteView.hidden = NO;
    _confirmView.hidden = YES;
    _friendView.hidden = YES;
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    
    return _friends.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Friend";
    InviteFriendCell *cell = (InviteFriendCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"InviteFriendCell" owner:nil options:nil];
        cell = array[0];
    
    }
    
   Friend *friend = [_friends objectAtIndex:[indexPath row]];
    cell.nameLabel.text = friend.username;
    [cell.avatarImageView setImageWithURL:[NSURL URLWithString:friend.avatar] placeholderImage:[UIImage imageNamed:@"carnetadresse-masque-photo.png"] ];

    
    [cell refreshView];
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
   InviteFriendCell *cell = (InviteFriendCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell check];
    
}


- (IBAction)confrimButtonAction:(id)sender {
    
   
}
- (IBAction)inviteButtonAction:(id)sender {
    
    [self.inviteView hide:YES];
    [self.friendView show:YES];
}
- (IBAction)sendButtonAction:(id)sender {
    
    NSMutableDictionary *requestBodyDict = [NSMutableDictionary dictionary];
    [requestBodyDict setObject:_meeting.meetingId forKey:@"meeting"];
    [requestBodyDict setObject:[self selectedFriends] forKey:@"participants"];
    _inviteFriends([requestBodyDict copy]);
    
     [self inviteFriends];
}

-(NSArray*)selectedFriends{
    
    NSMutableArray *selectedFriendsIds = [NSMutableArray array];
    for (int i=0, count = _friends.count; i< count; i++) {
       InviteFriendCell *cell =  (InviteFriendCell*)[_friendsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        if (cell.checked) {
            [selectedFriendsIds addObject:((Friend*)_friends[i]).friendId] ;
        }
    }
    return [selectedFriendsIds copy];
}




@end
