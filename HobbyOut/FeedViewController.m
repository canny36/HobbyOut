//
//  FeedViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 12/07/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedView.h"

#import "IIViewDeckController.h"
#import "BigNewsCell.h"

#import "MeetingDetailsViewController.h"

#import "ParticipationRequest.h"
#import "UserDefaultManager.h"

#import "MemberViewController.h"
#import "MeetingDetailsViewController.h"

#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"


@interface FeedViewController ()<FeedServiceDelegate, FriendRequestDelegate, ParticipateServiceDelegate, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_friends;
    NSArray *_invitations;
    NSArray *_participations;
    CLLocationManager *_locationManager;
    CLLocation  *_location;
    
    BigNewsCell *_currentCell;
}

@end

@implementation FeedViewController

-(id) init
{
    self = [super init];
    
    if (self)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        
        self.feedService = [[FeedService alloc]initWithDelegate:self];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(_refreshData) forControlEvents:UIControlEventValueChanged];
        
        self.friendRequestService = [[FriendRequestService alloc] initWithDelegate:self];
        self.participateService = [[ParticipateService alloc] initWithDelegate:self];
        
        
        
        
    }
    
    return self;
}


#pragma mark - Manage View

- (void) loadView
{
    self.view = [[FeedView alloc]init];
    [[self feedView].tableView addSubview:self.refreshControl];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self feedView].tableView.delegate = self;
    [self feedView].tableView.dataSource = self;
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
    [leftButton setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
    [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView)
         forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    
    self.navigationItem.title = @"ACTUALITES";
    
    
    if ([CLLocationManager locationServicesEnabled])
    {
        [_locationManager startMonitoringSignificantLocationChanges];
    }
    else
    {
        [self _refreshData];
    }
    
    
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:@"FeedViewController"];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

-(void) _refreshData
{
    [self.feedService getWithParameters:[self _createParams] forView:self.view];
}

-(NSDictionary *) _createParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    if (_location.coordinate.latitude != 0)
        [params setObject:[NSString stringWithFormat:@"%f",_location.coordinate.latitude] forKey:@"lat"];
    
    if (_location.coordinate.longitude != 0)
        [params setObject:[NSString stringWithFormat:@"%f",_location.coordinate.longitude] forKey:@"lng"];
    
    return params;
}


- (FeedView *) feedView
{
    return (FeedView *)self.view;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    
    if (section == 0)
    {
        return [_friends count];
    }
    
    if (section == 1)
    {
        return [_invitations count];
    }
    

    return [_participations count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *bigNewsCell = @"bigNewsCell";
    
    BigNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:bigNewsCell];
    
    if (!cell)
    {
        cell = [[BigNewsCell alloc] init];
        [cell.acceptButton addTarget:self action:@selector(_sendAccept:) forControlEvents:UIControlEventTouchUpInside];
        [cell.declineButton addTarget:self action:@selector(_sendDecline:) forControlEvents:UIControlEventTouchUpInside];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_displayEvent:)];
        [cell.eventLabel addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tapUser = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_displayMember:)];
        [cell.avatarView addGestureRecognizer:tapUser];
    }
    
    if ([indexPath section] == 0)
    {
        [cell displayFriendRequest:[_friends objectAtIndex:[indexPath row]]];
    }
    else if ([indexPath section] == 1)
    {
        [cell displayRequest:[_invitations objectAtIndex:[indexPath row]]];
    }
    else
    {
        [cell displayRequest:[_participations objectAtIndex:[indexPath row]]];
    }
    
    return cell;
}

#pragma mark Action

- (void) _displayEvent:(UIGestureRecognizer *)sender
{
    BigNewsCell *cell  = (BigNewsCell *) sender.view.superview;
    
    if (cell.invitation)
    {
        cell.invitation.meeting.isInvitation = YES;
       [self.navigationController pushViewController:[[MeetingDetailsViewController alloc]
                                                       initWithMeeting:cell.invitation.meeting] animated:YES];
    }
}

- (void) _displayMember:(UIGestureRecognizer *)sender
{
    BigNewsCell *cell  = (BigNewsCell *) sender.view.superview;
    
    
    if (cell.invitation)
    {
        
        if ([cell.invitation isKindOfClass:[ParticipationRequest class]])
        {
            [self.navigationController pushViewController:[[MemberViewController alloc]
                                                           initWithMemberId:cell.invitation.memberId] animated:YES];
        }
        else
        {
            [self.navigationController pushViewController:[[MemberViewController alloc]
                                                           initWithMemberId:cell.invitation.otherMemberId] animated:YES];
        }
    }
    
    if (cell.friendRequest)
    {
        [self.navigationController pushViewController:[[MemberViewController alloc]
                                                       initWithMemberId:cell.friendRequest.memberId] animated:YES];
    }

}

- (void) _sendAccept:(UIButton *) button
{
    [self _doReplyWithState:@"2" forButton:button];
}

- (void) _sendDecline:(UIButton *) button
{
     [self _doReplyWithState:@"-1" forButton:button];
}

- (void) _doReplyWithState:(NSString *) state forButton:(UIButton *) button
{
    BigNewsCell *cell  = (BigNewsCell *) button.superview.superview;
    _currentCell = cell;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:state forKey:@"state"];
    
    if (cell.invitation)
    {
        [params setValue:cell.invitation.meetingId forKey:@"meeting"];
        
        if ([cell.invitation class] == [ParticipationRequest class])
        {
            [params setValue:cell.invitation.memberId forKey:@"participant"];
        }
        
        
        [self.participateService postWithParameters:params forView:self.view];
    }
    
    if (cell.friendRequest)
    {
        [params setValue:cell.friendRequest.memberId forKey:@"friend_id"];
        [self.friendRequestService postWithParameters:params forView:self.view];
    }
}

#pragma mark - FeedService Delegate

- (void) feedRetreived:(NSArray *) friends invitations:(NSArray *)invitations participations:(NSArray *)participations
{
    _friends = friends;
    _participations = participations;
    _invitations = invitations;
    
    if ( [_invitations count] == 0 &&
        [_participations count] == 0 &&
        [_friends count] == 0)
    {
        [self feedView].noDataFrame.hidden = NO;
    }
    else
    {
        [self feedView].noDataFrame.hidden = YES;
    }
    
    [[self feedView].tableView reloadData];
    [self.refreshControl endRefreshing];
}

#pragma  mark - FriendRequestServiceDelegate

- (void) requestAnswered
{
    [self.feedService getWithParameters:nil forView:self.view];
    _currentCell = nil;
}

#pragma  mark - ParticipateService Delegate

-(void) participate:(ParticipateService *)participateService status:(NSInteger)status
{
    [self.feedService getWithParameters:nil forView:self.view];
    _currentCell = nil;
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _location = [locations lastObject];
    [self _refreshData];
    
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error
{
    [manager stopUpdatingLocation];
    NSLog(@"error%@",error);
    [self _refreshData];
}


@end
