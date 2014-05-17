//
//  TribuneDetailsViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 24/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TribuneDetailsViewController.h"
#import "TribuneDetailsView.h"
#import "MemberEventCell.h"

#import "MeetingMapViewController.h"

#import "UIImageView+WebCache.h"

#import "PlaceMark.h"
#import "TribuneBroadcastCell.h"

#import "MeetingDetailsViewController.h"


@interface TribuneDetailsViewController ()<UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, MemberServiceDelegate>

@end

@implementation TribuneDetailsViewController
{
    NSString *_memberId;
    CLLocationManager *_locationManager;
    CLLocation* _location;
}

-(id) initWithMemberId:(NSString *) memberId
{
    self = [super init];
    
    if (self)
    {
        _memberId= memberId;
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(_goBack) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.memberservice = [[MemberService alloc] initWithDelegate:self];
        self.memberservice.path = [self.memberservice.path stringByAppendingFormat:@"/%@", memberId];
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        if ([CLLocationManager locationServicesEnabled])
        {
            [_locationManager startMonitoringSignificantLocationChanges];
        }
        else
        {
            [self _refreshData];
        }
        
    }
    
    return self;
}

-(void) _refreshData
{
   [self.memberservice getWithParameters:[self _createParams] forView:self.view];
}

-(void) _goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void) loadView
{
    self.view = [[TribuneDetailsView alloc] init];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self tribuneDetailsView].tableView.delegate = self;
    [self tribuneDetailsView].tableView.dataSource = self;
    
    [[self tribuneDetailsView].eventsButton addTarget:self
                                               action:@selector(_eventsClicked)
                                     forControlEvents:UIControlEventTouchUpInside];
    
    [[self tribuneDetailsView].broadcastsButton addTarget:self
                                               action:@selector(_broadcastClicked)
                                     forControlEvents:UIControlEventTouchUpInside];
    
    [[self tribuneDetailsView].mapButton addTarget:self action:@selector(_displayMap)
                                  forControlEvents:UIControlEventTouchUpInside];
    
}

-(void) _displayMap
{
    MeetingMapViewController *mapViewController = [[MeetingMapViewController alloc] initWithTitle:self.member.username
                                                                                     andPlaceMark:[[PlaceMark alloc] initWithMember:self.member]];

    [self.navigationController pushViewController:mapViewController animated:YES];
}

-(void) _eventsClicked
{
    [self tribuneDetailsView].tableView .rowHeight = 161;
    [self tribuneDetailsView].eventsButton.selected = YES;
    [self tribuneDetailsView].broadcastsButton.selected = NO;
    [[self tribuneDetailsView].tableView reloadData];

}

-(void) _broadcastClicked
{
    [self tribuneDetailsView].tableView.rowHeight = 145;
    [self tribuneDetailsView].eventsButton.selected = NO;
    [self tribuneDetailsView].broadcastsButton.selected = YES;
    [[self tribuneDetailsView].tableView reloadData];

}

-(TribuneDetailsView *) tribuneDetailsView
{
    return (TribuneDetailsView *)self.view;
}


-(void) _displayMember
{
    self.navigationItem.title = self.member.etablissement;
    
    if (self.member.avatarUrl)
        [[self tribuneDetailsView].avatarView setImageWithURL:[NSURL URLWithString:self.member.avatarUrl]];
    
    [self tribuneDetailsView].distanceLabel.text = self.member.distanceString;
    [self tribuneDetailsView].address2Label.text = [self.member.postcode stringByAppendingFormat:@" %@", self.member.ville];
    [self tribuneDetailsView].addressLabel.text = self.member.adresse;
    
    [[self tribuneDetailsView].tribuneTypeImageView setImage:self.member.icon];
    [[self tribuneDetailsView].tribuneHeaderImageView setImage:self.member.bigHeader];
    
    [self tribuneDetailsView].barCategoryLabel.text = self.member.typeLabel;
    
    if (self.member.nbTV > 1)
    {
        [self tribuneDetailsView].equipmentLabel.text = [NSString stringWithFormat:@"%i TVs", self.member.nbTV ];
    }
    else
    {
        [self tribuneDetailsView].equipmentLabel.text = [NSString stringWithFormat:@"%i TV", self.member.nbTV ];
    }
    
    [[self tribuneDetailsView].tableView reloadData];
}

#pragma mark UITABLEVIES DELEGATE & DATASOURCE

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    int count;
    if ([self tribuneDetailsView].eventsButton.selected == YES)
    {
        count = [self.member.meetingsOrganising count];
    }
    else
    {
        count = [self.member.tvBroadcasts count];
    }
    return count;
}




- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *EventCellIdentifier = @"MEMBER_EVENT_CELL";
    static NSString *BroadcastCellIdentifier = @"MEMBER_TV_CELL";
    
    UITableViewCell *cell;
    if ([self tribuneDetailsView].eventsButton.selected == YES)
    {
    
        cell = (MemberEventCell *)[tableView dequeueReusableCellWithIdentifier:EventCellIdentifier];
        if (cell == nil) {
            cell = [[MemberEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:EventCellIdentifier];
        }
        
        [(MemberEventCell *)cell displayEvent:[self.member.meetingsOrganising objectAtIndex:[indexPath row]]];
    }
    else
    {
        cell = (TribuneBroadcastCell *)[tableView dequeueReusableCellWithIdentifier:BroadcastCellIdentifier];
        if (cell == nil) {
            cell = [[TribuneBroadcastCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BroadcastCellIdentifier];
        }
        
        [(TribuneBroadcastCell *)cell displayTvBroadcast:[self.member.tvBroadcasts objectAtIndex:indexPath.row]];
    }
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self tribuneDetailsView].eventsButton.selected == YES)
    {
        Meeting *meeting = [self.member.meetingsOrganising objectAtIndex:[indexPath row]];
        
        [self.navigationController pushViewController:[[MeetingDetailsViewController alloc] initWithMeeting:meeting] animated:YES];
    }
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



#pragma mark MemberServiceDelegate
-(void) memberRetreved:(MemberService*)memberService  andMemberData:(NSDictionary *)memberData
{
    self.member = [[Member alloc] initWithDictionary:memberData];
    [self _displayMember];
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


@end
