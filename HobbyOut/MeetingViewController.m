//
//  MeetingViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 28/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MeetingViewController.h"
#import "MeetingView.h"

#import "MeetingCell.h"

#import "UIImageView+WebCache.h"

#import "Meeting.h"

#import "MeetingMapViewController.h"
#import "PlaceMark.h"

#import "TribuneDetailsViewController.h"
#import "MemberViewController.h"

#import "UserDefaultManager.h"

#import "PleaseRegisterViewController.h"



@interface MeetingViewController ()<UITableViewDataSource, UITableViewDelegate, ParticipateServiceDelegate>
{
    MeetingCell *_currentMeetingCell;
}

@end

@implementation MeetingViewController

-(id) initWithTvBroadcast:(TvBroadcast *) tvBroadcast
{
    self = [super init];
    
    if (self)
    {
        self.tvBroadcast = tvBroadcast;
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(_goBack) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.title = @"OÙ VOIR LE PROGRAMME";
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.participateService = [[ParticipateService alloc] initWithDelegate:self];
    }
    
    return self;
}

-(void) _goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loadView
{
    self.view = [[MeetingView alloc]init];
    [self meetingView].meetingTableView.delegate = self;
    [self meetingView].meetingTableView.dataSource = self;
    
    [self meetingView].nameLabel.text = self.tvBroadcast.name;
    [self meetingView].categoryLabel.text = self.tvBroadcast.category;
    [self meetingView].dateLabel.text = self.tvBroadcast.fullDate;
    
    [self.meetingView.broadcasterImageView setImageWithURL:[NSURL URLWithString:self.tvBroadcast.broadcasterPath]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tvBroadcast.meetings count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MEETING_CELL";
    MeetingCell *cell = (MeetingCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MeetingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Meeting *meeting = [self.tvBroadcast.meetings objectAtIndex:[indexPath row]];
    [cell displayMeeting:meeting];
    [cell.mapButton addTarget:self action:@selector(_displayMap:)
             forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_displayOrganiser:)];
    [cell.nameLabel addGestureRecognizer:tap];
    
    [cell.participateButton addTarget:self action:@selector(_participate:)
                     forControlEvents:UIControlEventTouchUpInside];
    return cell;
}


-(void) _displayMap:(UIButton *)sender
{
    MeetingCell *cell = (MeetingCell *) [sender superview];
    
    MeetingMapViewController *mapViewController = [[MeetingMapViewController alloc] initWithTitle:self.tvBroadcast.name andPlaceMark:[[PlaceMark alloc] initWithMeeting:cell.meeting]];
    [self.navigationController pushViewController:mapViewController animated:YES];
}

-(void) _participate:(UIButton *)sender
{
    if ([UserDefaultManager getSessionToken])
    {
        MeetingCell *cell = (MeetingCell *) [sender superview];
    
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                cell.meeting.meetingId, @"meeting",
                                @"1", @"state",
                                nil];
        _currentMeetingCell = cell;
        [self.participateService postWithParameters:params forView:self.view];
    }
    else
    {
        [self.navigationController pushViewController:[[PleaseRegisterViewController alloc]init] animated:YES];
    }
    
}

-(void) _displayOrganiser:(UITapGestureRecognizer *)recognizer
{
    if ([UserDefaultManager getSessionToken])
    {
        MeetingCell *cell = (MeetingCell *) [recognizer.view superview];
        
        if (cell.meeting.isTribune)
        {
            TribuneDetailsViewController *tribuneDetailsViewController = [[TribuneDetailsViewController alloc] initWithMemberId:cell.meeting.memberId];
            [self.navigationController pushViewController:tribuneDetailsViewController animated:YES];
        }
        else if (cell.meeting.typeLieu == 1)
        {
            MemberViewController *memberViewController = [[MemberViewController alloc] initWithMemberId:cell.meeting.memberId];
            [self.navigationController pushViewController:memberViewController animated:YES];
        }
        else if (cell.meeting.typeLieu == 2)
        {
            TribuneDetailsViewController *tribuneDetailsViewController = [[TribuneDetailsViewController alloc] initWithMemberId:cell.meeting.tribuneId];
            [self.navigationController pushViewController:tribuneDetailsViewController animated:YES];
        }
    }
}


-(MeetingView *) meetingView
{
    return (MeetingView *) self.view;
}

#pragma mark ParticipateServiceDelegate
- (void) participate:(ParticipateService*)participateService status:(NSInteger)status
{
    _currentMeetingCell.meeting.participantStatus = status;
    [_currentMeetingCell refresh];
    
    _currentMeetingCell = nil;
}



@end
