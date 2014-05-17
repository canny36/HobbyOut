//
//  MeetingDetailsViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MeetingDetailsViewController.h"
#import "MeetingDetailsView.h"

#import "UIImageView+WebCache.h"

#import "MeetingMapViewController.h"
#import "UserDefaultManager.h"
#import "Member.h"

#import "Participant.h"

#import "TribuneDetailsViewController.h"
#import "MemberViewController.h"

#import "UserDefaultManager.h"
#import "PleaseRegisterViewController.h"
#import "MBProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "AppStyle.h"
#import "MZFormSheetController/MZFormSheetController.h"
#import "InviteFriendViewController.h"
#import "InviteFriendService.h"

@interface MeetingDetailsViewController ()<ParticipateServiceDelegate, ParticipantPopUpDelegate>

@end

@implementation MeetingDetailsViewController

-(id) initWithMeeting:(Meeting *) meeting
{
    self = [super init];
    
    if (self)
    {
        self.meeting = meeting;
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(_goBack) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.title = meeting.eventName;
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.participateService = [[ParticipateService alloc] initWithDelegate:self];
        
        self.popUpController = [[ParticipantPopUpViewController alloc] init];
        self.popUpController.delegate = self;
        self.popUpController.participants = meeting.participants;
    }
    
    return self;
}

-(void) _goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) loadView
{
    self.view = [[MeetingDetailsView alloc] init];
    
    UITapGestureRecognizer *tapper = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_showParticipantPopUp)];
    [[self meetingDetailsView].touchParticipantView addGestureRecognizer:tapper];
    
    [[self meetingDetailsView].participantPopUp.closeButtonPopUp addTarget:self action:@selector(_closePopUp)
                                                          forControlEvents:UIControlEventTouchUpInside];
    [self.popUpController setView:[self meetingDetailsView].participantPopUp];
}

-(void) _showParticipantPopUp
{
    if ([UserDefaultManager getSessionToken])
    {
        [self meetingDetailsView].participantPopUp.hidden = NO;
    }
}

-(void) _closePopUp
{
    [self meetingDetailsView].participantPopUp.hidden = YES;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [[self meetingDetailsView].mapButton addTarget:self action:@selector(_displayMap)
                                  forControlEvents:UIControlEventTouchUpInside];
    
    [[self meetingDetailsView].participateButton addTarget:self
                                                    action:@selector(_participate)
                                          forControlEvents:UIControlEventTouchUpInside];
    [[self meetingDetailsView].inviteFriends addTarget:self
                                                    action:@selector(_inviteFriends)
                                          forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tapPlaceName = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(_displayOrganiser)];
    [[self meetingDetailsView].placeNameLabel addGestureRecognizer:tapPlaceName];
    
    UITapGestureRecognizer *tapPlaceHeader = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                   action:@selector(_displayOrganiser)];
    [[self meetingDetailsView].placeHeader addGestureRecognizer:tapPlaceHeader];
    
    
    
    NSInteger status = [self.meeting getStatus];
    
    if (status == 1 || status == 2 || status == -1 || status == 3 || status == 10 )
    {
        [self meetingDetailsView].participateButton.hidden = YES;
        [self meetingDetailsView].inviteFriends.hidden = NO;
        [self meetingDetailsView].nbPlace.hidden = YES;
        [self meetingDetailsView].statusLabel.hidden = NO;
        [self meetingDetailsView].statusLabel.text = [self.meeting getStatusLabel];
    }
    else
    {
        [self meetingDetailsView].statusLabel.hidden = YES;
        [self meetingDetailsView].participateButton.hidden = NO;
        [self meetingDetailsView].nbPlace.hidden = NO;
        [self meetingDetailsView].inviteFriends.hidden = YES;
    }
    
    
    [self meetingDetailsView].participant1.hidden = YES;
    [self meetingDetailsView].participant2.hidden = YES;
    [self meetingDetailsView].participant3.hidden = YES;
    [self meetingDetailsView].participant4.hidden = YES;
    [self meetingDetailsView].participant5.hidden = YES;
    [self meetingDetailsView].participant6.hidden = YES;
    [self meetingDetailsView].participantMore.hidden = YES;
    [self meetingDetailsView].moreNumberLabel.hidden = YES;
    
    [self meetingDetailsView].eventNameLabel.text = self.meeting.eventName;
    [self meetingDetailsView].categoryLabel.text = self.meeting.category;
    [self meetingDetailsView].dateLabel.text = [NSString stringWithFormat:@"%@ - %@",self.meeting.fullDate, self.meeting.hour ];
    
    [self meetingDetailsView].placeNameLabel.text = [self.meeting getName];
    [self meetingDetailsView].distanceLabel.text = self.meeting.distanceString;
    [self meetingDetailsView].cityLabel.text = [self.meeting.postcode stringByAppendingFormat:@" %@", self.meeting.ville];
    [self meetingDetailsView].adressLabel.text = self.meeting.adresse;
    
    NSInteger count = [self.meeting.participants count];
    
    
    if (self.meeting.typeLieu == 1)
    {
        [[self meetingDetailsView].placeHeader setImageWithURL:[NSURL URLWithString:self.meeting.avatar]];
        self.meetingDetailsView.placeHeader.frame = CGRectMake(23, 160, 54, 45);;
    }
    else
    {
        [[self meetingDetailsView].placeHeader setImage:self.meeting.header];
    }
    
    
    if (count > 1)
        [self meetingDetailsView].nbParticipantLabel.text = [NSString stringWithFormat:@"%u participants", count];
    else
        [self meetingDetailsView].nbParticipantLabel.text = [NSString stringWithFormat:@"%u participant", count];
    
    if (count > 0)
    {
        [self meetingDetailsView].participant1.hidden = NO;
        [[self meetingDetailsView].participant1 setImageWithURL:[NSURL URLWithString:((Participant *)[self.meeting.participants objectAtIndex:0]).avatarUrl]];
    }
    
    if (count > 1)
    {
        [self meetingDetailsView].participant2.hidden = NO;
        [[self meetingDetailsView].participant2 setImageWithURL:[NSURL URLWithString:((Participant *)[self.meeting.participants objectAtIndex:1]).avatarUrl]];
    }
    
    if (count> 2)
    {
        [self meetingDetailsView].participant3.hidden = NO;
        [[self meetingDetailsView].participant3 setImageWithURL:[NSURL URLWithString:((Participant *)[self.meeting.participants objectAtIndex:2]).avatarUrl]];
    }
    
    if (count > 3)
    {
        [self meetingDetailsView].participant4.hidden = NO;
        [[self meetingDetailsView].participant4 setImageWithURL:[NSURL URLWithString:((Participant *)[self.meeting.participants objectAtIndex:3]).avatarUrl]];
    }
    
    if (count > 4)
    {
        [self meetingDetailsView].participant5.hidden = NO;
        [[self meetingDetailsView].participant5 setImageWithURL:[NSURL URLWithString:((Participant *)[self.meeting.participants objectAtIndex:4]).avatarUrl]];
    }
    
    if (count > 5)
    {
        [self meetingDetailsView].participant6.hidden = NO;
        [[self meetingDetailsView].participant6 setImageWithURL:[NSURL URLWithString:((Participant *)[self.meeting.participants objectAtIndex:5]).avatarUrl]];
    }
    
    if (count == 7)
    {
        [self meetingDetailsView].participantMore.hidden = NO;
        [[self meetingDetailsView].participantMore setImageWithURL:[NSURL URLWithString:((Participant *)[self.meeting.participants objectAtIndex:6]).avatarUrl]];
    }
    
    if (count > 7)
    {
        [self meetingDetailsView].participantMore.hidden = NO;
        [self meetingDetailsView].moreNumberLabel.hidden = NO;
        [self meetingDetailsView].moreNumberLabel.text = [NSString stringWithFormat:@" +%u", (count - 6)];
        
    }
    
    [self meetingDetailsView].nbPlace.text = [self.meeting getNbPlace];
}


-(MeetingDetailsView *) meetingDetailsView
{
    return (MeetingDetailsView *) self.view;
}

-(void) _displayMap
{
        MeetingMapViewController *mapViewController = [[MeetingMapViewController alloc] initWithTitle:self.meeting.eventName andPlaceMark:[[PlaceMark alloc] initWithMeeting:self.meeting]];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

-(void) _displayOrganiser
{
    if ([UserDefaultManager getSessionToken])
    {
        if (self.meeting.isTribune)
        {
            TribuneDetailsViewController *tribuneDetailsViewController = [[TribuneDetailsViewController alloc] initWithMemberId:self.meeting.memberId];
            [self.navigationController pushViewController:tribuneDetailsViewController animated:YES];
        }
        else if (self.meeting.typeLieu == 1)
        {
            MemberViewController *memberViewController = [[MemberViewController alloc] initWithMemberId:self.meeting.memberId];
            [self.navigationController pushViewController:memberViewController animated:YES];
        }
        else if (self.meeting.typeLieu == 2)
        {
            TribuneDetailsViewController *tribuneDetailsViewController = [[TribuneDetailsViewController alloc] initWithMemberId:self.meeting.tribuneId];
            [self.navigationController pushViewController:tribuneDetailsViewController animated:YES];
        }
    }
}

-(void) _participate
{
    if ([UserDefaultManager getSessionToken])
    {
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                self.meeting.meetingId, @"meeting",
                                @"1", @"state",
                                nil];
    
        [self.participateService postWithParameters:params forView:self.view];
    }
    else
    {
        [self.navigationController pushViewController:[[PleaseRegisterViewController alloc]init] animated:YES];
    }
    
}

-(void)_inviteFriends{
    
    
    InviteFriendViewController *vc =  [[InviteFriendViewController alloc]init];
    vc.meeting = _meeting;
    vc.dismissBlock = ^(NSString *message){
        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
            [self showMessage:message];
        }];
    };
    vc.inviteFriends = ^(NSDictionary *dict){
        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
           
        }];
        [self sendInviteFriends:dict];
    };
    MZFormSheetController *controller = [[MZFormSheetController alloc] initWithViewController:vc];
    controller.shouldCenterVertically = YES;
    controller.presentedFormSheetSize = CGSizeMake(300, 400);
    controller.shouldDismissOnBackgroundViewTap = YES;
  
   
    // present form sheet with view controller
    [self mz_presentFormSheetController:controller animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}

-(void)sendInviteFriends:(NSDictionary*)requestDict{
    
    InviteFriendService *inviteFriendService = [[InviteFriendService alloc] init];
    inviteFriendService.onSuccess = ^(NSDictionary *response){
        NSString *message = nil;
        NSLog(@"Invite friends : %@ ",response);
        NSNumber *number =response[@"success"] ;
        if ([number boolValue]) {
            message  = @"Invited successfully";
            [self confirmPopup];
        }else{
            message = @"Failed To Invite";
            [self showMessage:message];
        }
    };
    inviteFriendService.onFail = ^(NSString *error){
        NSLog(@"Invite friends : %@ ",error);
    };
    
    [inviteFriendService postWithParameters:requestDict forView:self.view];
}

-(void)confirmPopup{
    InviteFriendViewController *vc =  [[InviteFriendViewController alloc]init];
    vc.meeting = _meeting;
    vc.dismissBlock = ^(NSString *message){
        [self mz_dismissFormSheetControllerAnimated:YES completionHandler:^(MZFormSheetController *formSheetController) {
//            [self showMessage:message];
        }];
    };
//    vc.inviteFriends = ^(NSDictionary *dict){
//        [self sendInviteFriends:dict];
//    };
    MZFormSheetController *controller = [[MZFormSheetController alloc] initWithViewController:vc];
    controller.shouldCenterVertically = YES;
    controller.presentedFormSheetSize = CGSizeMake(300, 400);
    controller.shouldDismissOnBackgroundViewTap = YES;
    
    
    // present form sheet with view controller
    [self mz_presentFormSheetController:controller animated:YES completionHandler:^(MZFormSheetController *formSheetController) {
        
    }];
}

-(void)showMessage:(NSString*)text{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.detailsLabelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    [self.view addSubview:hud];
    [hud show:YES];
    [hud hide:YES afterDelay:3];
}

#pragma mark ParticipateServiceDelegate
- (void) participate:(ParticipateService*)participateService status:(NSInteger)status
{
    self.meeting.participantStatus = status;
    
    if (status == 2)
    {
        Member *user = [UserDefaultManager getUser];
        [self.meeting.participants addObject:[[Participant alloc]initWithName:user.name
                                                                       userId:user.memberId
                                                                 andAvatarUrl:user.avatarUrl]];
        
        [self.popUpController refresh];
    }
    
    [self viewDidLoad];
}

#pragma mark ParticipantPopUpDelegate

-(void) didSelectParticipant:(Participant *)participant
{
    MemberViewController *memberViewController = [[MemberViewController alloc] initWithMemberId:participant.userId];
    
    [self.navigationController pushViewController:memberViewController animated:YES];
}

@end
