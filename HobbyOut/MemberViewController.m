//
//  MemberViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 05/06/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberView.h"
#import "UserDefaultManager.h"

#import "SportTableViewController.h"

#import "IIViewDeckController.h"
#import "UIImageView+WebCache.h"

#import "MemberEventCell.h"

#import "AppStyle.h"
#import "WelcomeViewController.h"

#import "MeetingDetailsViewController.h"
#import "AddSportViewController.h"
#import "AddFriendService.h"



@interface MemberViewController ()<UITableViewDataSource, UITableViewDelegate, MemberServiceDelegate, AddSportDelegate, CLLocationManagerDelegate>
{
    SportTableViewController *_sportTableViewController;
    NSMutableArray *_sections;
    NSMutableArray *_items;
    CLLocationManager *_locationManager;
    CLLocation* _location;
}

@end

@implementation MemberViewController

-(id) init
{
   return [self initWithMemberId:nil];
}

-(id) initWithMemberId:(NSString *) memberId
{
    self = [super init];
    if (self) {
        
        self.memberId = memberId;
        
        _items = [NSMutableArray array];
        _sections = [NSMutableArray array];
        [_sections addObject:@"Sports favoris"];
        
        [_sections addObject:@""];
        
        if (memberId)
        {
            UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
            [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
            [backButton addTarget:self action:@selector(_goBack) forControlEvents:UIControlEventTouchUpInside];
            
            self.navigationItem.hidesBackButton = YES;
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
            
            if (_member.friendStatus == 1 ) {
                [self addFriendButton];
            }
            // Add friend button
            

        }
        else
        {
        
            UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
            [leftButton setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
            [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView)
                 forControlEvents:UIControlEventTouchUpInside];
            
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
            
            UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
            [rightButton setImage:[UIImage imageNamed:@"decoButton.png"] forState:UIControlStateNormal];
            [rightButton addTarget:self action:@selector(_logout) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *editor = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 84, 29)];
            [editor setImage:[UIImage imageNamed:@"profil-icon-edit.png"] forState:UIControlStateNormal];
            [editor setTitle:@"Editer" forState:UIControlStateNormal];
            [editor setTitleColor:[UIColor colorWithRed:250.0/255 green:105.0/255 blue:11.0/255 alpha:1] forState:UIControlStateNormal];
            editor.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
            [editor setBackgroundImage:[UIImage imageNamed:@"profil-fond-bt-1.png"] forState:UIControlStateNormal];
        
            [editor addTarget:self action:@selector(_edit) forControlEvents:UIControlEventTouchUpInside];

             self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editor];

        }
        
        _sportTableViewController = [[SportTableViewController alloc] init];
        
        self.memberService = [[MemberService alloc] initWithDelegate:self];
        
        if (memberId)
            self.memberService.path = [self.memberService.path stringByAppendingFormat:@"/%@", memberId];
        else
        {
            self.member = [UserDefaultManager getUser];
            self.navigationItem.title = self.member.name;
        }
        
        
        self.updateUserService = [[UpdateUserService alloc]init];
        
        
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

-(void) _goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) loadView
{
    self.view = [[MemberView alloc] init];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self memberView].sportsTableView.dataSource = _sportTableViewController;
    [self memberView].sportsTableView.delegate = _sportTableViewController;
    [self memberView].eventsTableView.delegate = self;
    [self memberView].eventsTableView.dataSource = self;
    
    [[self memberView].editButton addTarget:self action:@selector(_edit) forControlEvents:UIControlEventTouchUpInside];
    [[self memberView].okButton addTarget:self action:@selector(_okEdit) forControlEvents:UIControlEventTouchUpInside];
    [[self memberView].cancelButton addTarget:self action:@selector(_cancelEdit) forControlEvents:UIControlEventTouchUpInside];
    
    [[self memberView].addButton addTarget:self action:@selector(_addSport) forControlEvents:UIControlEventTouchUpInside];
    
    if (self.memberId)
    {
        [self memberView].editButton.hidden = YES;
    }
    
    [self _displayMember];
}

-(MemberView *) memberView
{
    return (MemberView*) self.view;
}

- (void) _displayMember
{
    
    if (self.member)
    {
        NSLog(@"Member Avatar %@ ",self.member.avatarUrl);
        if (self.member.avatarUrl)
            [[self memberView].avatarView setImageWithURL:[NSURL URLWithString:self.member.avatarUrl]];
        
        [self memberView].descLabel.text = [self.member getDesc];
        [self memberView].badgeLabel.text = self.member.badge;
        [self memberView].pointLabel.text = [self.member getPoints];
        
        if (_memberId) {
             self.navigationItem.rightBarButtonItem = nil;
        }
        
        if (_memberId && self.member.friendStatus == 1) {
            [self addFriendButton];
        }
        
        _sportTableViewController.sportArray = self.member.categories;
        
        _items = [NSMutableArray array];
        _sections = [NSMutableArray array];
        [_sections addObject:@"Sports favoris"];
        
        [_sections addObject:@""];
        if ([self.member.meetingsOrganising count] > 0)
        {
            [_sections addObject:@"Organise ces événements"];
            [_items addObject:self.member.meetingsOrganising];
        }
        
        if ([self.member.meetingsParticipating count] > 0)
        {
            [_sections addObject:@"Participe à ces événements"];
            [_items addObject:self.member.meetingsParticipating];
        }
        
        self.memberView.sportsTableView.hidden = FALSE;
        
    }
}


-(void) _refreshData
{
    [self.memberService getWithParameters:[self _createParams] forView:self.view];
}

-(void)addFriendButton{
    UIButton *addFriendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 29)];
    //            [editor setImage:[UIImage imageNamed:@"profil-icon-edit.png"] forState:UIControlStateNormal];
    [addFriendButton setTitle:@"+1 Ami(e)" forState:UIControlStateNormal];
    [addFriendButton setTitleColor:[UIColor colorWithRed:250.0/255 green:105.0/255 blue:11.0/255 alpha:1] forState:UIControlStateNormal];
    addFriendButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    [addFriendButton setBackgroundImage:[UIImage imageNamed:@"profil-fond-bt-2.png"] forState:UIControlStateNormal];
    
    [addFriendButton addTarget:self action:@selector(_addFriend) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addFriendButton];
}

#pragma mark Action

-(void)_addFriend{
    AddFriendService *friendService = [[AddFriendService alloc] initWithDelegate:^(NSDictionary *response) {
        NSLog(@"Add friend response %@ ",response);
        if ([response[@"status"] intValue] == 1) {
            
        }else{
            [self showMessage:response[@"message"]];
        }
    }];
    NSMutableDictionary *requestDict = [NSMutableDictionary dictionary];
    [requestDict setObject:@"1" forKey:@"state"];
     [requestDict setObject:_memberId forKey:@"friend_id"];
    [friendService postWithParameters:requestDict forView:self.view];
}

-(void) _logout
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Déconnexion" message:@"Veux-tu vraiment te déconnecter ?" delegate:self cancelButtonTitle:@"Oui" otherButtonTitles:@"Non", nil];
    [alert show];
}

-(void) _edit
{
    
    [[self memberView].sportsTableView setEditing:YES animated:YES];
    
    UIButton *annuler = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 29)];
    //            [editor setImage:[UIImage imageNamed:@"profil-icon-edit.png"] forState:UIControlStateNormal];
    [annuler setTitle:@"Annuler" forState:UIControlStateNormal];
    [annuler setTitleColor:[UIColor colorWithRed:250.0/255 green:105.0/255 blue:11.0/255 alpha:1] forState:UIControlStateNormal];
    annuler.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    [annuler setBackgroundImage:[UIImage imageNamed:@"profil-fond-bt-2.png"] forState:UIControlStateNormal];
    
    [annuler addTarget:self action:@selector(_cancelEdit) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *okEdit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 29)];
    [okEdit setImage:[UIImage imageNamed:@"profil-icon-valid.png"] forState:UIControlStateNormal];
    [okEdit setTitle:@"Ok" forState:UIControlStateNormal];
    [okEdit setTitleColor:[UIColor colorWithRed:250.0/255 green:105.0/255 blue:11.0/255 alpha:1] forState:UIControlStateNormal];
    okEdit.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:12];
    [okEdit setBackgroundImage:[UIImage imageNamed:@"profil-fond-bt-3.png"] forState:UIControlStateNormal];
    
    [okEdit addTarget:self action:@selector(_okEdit) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:okEdit],[[UIBarButtonItem alloc] initWithCustomView:annuler]];
    
//    [self memberView].editButton.hidden = YES;
    [self memberView].addButton.hidden = NO;
//    [self memberView].okButton.hidden = NO;
//    [self memberView].cancelButton.hidden = NO;
}

-(void) _cancelEdit
{
    [[self memberView].sportsTableView setEditing:NO animated:YES];
    [self _refreshData];
    
     self.navigationItem.rightBarButtonItems = nil;
    
    UIButton *editor = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 84, 29)];
    [editor setImage:[UIImage imageNamed:@"profil-icon-edit.png"] forState:UIControlStateNormal];
    [editor setTitle:@"Editer" forState:UIControlStateNormal];
    [editor setTitleColor:[UIColor colorWithRed:250.0/255 green:105.0/255 blue:11.0/255 alpha:1] forState:UIControlStateNormal];
    editor.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [editor setBackgroundImage:[UIImage imageNamed:@"profil-fond-bt-1.png"] forState:UIControlStateNormal];
    
    [editor addTarget:self action:@selector(_edit) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editor];

    [self memberView].editButton.hidden = NO;
//    [self memberView].addButton.hidden = YES;
//    
//    [self memberView].okButton.hidden = YES;
//    [self memberView].cancelButton.hidden = YES;
}

-(void) _okEdit
{
    [[self memberView].sportsTableView setEditing:NO animated:YES];
    
    self.navigationItem.rightBarButtonItems = nil;
    
    UIButton *editor = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 84, 29)];
    [editor setImage:[UIImage imageNamed:@"profil-icon-edit.png"] forState:UIControlStateNormal];
    [editor setTitle:@"Editer" forState:UIControlStateNormal];
    [editor setTitleColor:[UIColor colorWithRed:250.0/255 green:105.0/255 blue:11.0/255 alpha:1] forState:UIControlStateNormal];
    editor.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [editor setBackgroundImage:[UIImage imageNamed:@"profil-fond-bt-1.png"] forState:UIControlStateNormal];
    [editor addTarget:self action:@selector(_edit) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editor];
    [self memberView].editButton.hidden = NO;
    [self memberView].addButton.hidden = YES;
//
//    [self memberView].okButton.hidden = YES;
//    [self memberView].cancelButton.hidden = YES;
    
    NSDictionary *params = @{@"categories":self.member.sportJson};
    
    [self.updateUserService postWithParameters:params forView:self.view];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        
        [UserDefaultManager logout];
        
        
        self.viewDeckController.leftController = nil;
        self.viewDeckController.rightController = nil;
        
        [self.navigationController
         setViewControllers:[NSArray arrayWithObject:[[WelcomeViewController alloc] init]]  animated:NO];
    }
}

- (void) _addSport
{
    AddSportViewController *addSportController = [[AddSportViewController alloc]init];
    addSportController.delegate = self;
    addSportController.sportToFilter = self.member.categories;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addSportController];
    [AppStyle navigationBar:navigationController.navigationBar];
    [self presentViewController:navigationController animated:YES completion:nil];
}


#pragma mark MemberServiceDelegate

-(void) memberRetreved:(MemberService*)memberService andMemberData:(NSDictionary *)memberData
{
    if (!self.memberId)
        [UserDefaultManager setUser:memberData];
    
    self.member = [[Member alloc] initWithDictionary:memberData];
    self.navigationItem.title = self.member.name;

    [self _displayMember]; 
  
    [[self memberView].eventsTableView reloadData];
    [[self memberView].sportsTableView reloadData];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1)
        return 0;
    
    return [[_items objectAtIndex:(section - 2)] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
    if (section == 1)
    {
        return [self memberView].sportsTableView;
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
           label.text = [_sections objectAtIndex:section];
        
    [AppStyle memberCat1Label:label];
	return label;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MEMBER_EVENT_CELL";
    MemberEventCell *cell = (MemberEventCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MemberEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
        
    [cell displayEvent:[[_items objectAtIndex:[indexPath section] - 2] objectAtIndex:[indexPath row]]];

    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Meeting *meeting = [[_items objectAtIndex:[indexPath section] - 2] objectAtIndex:[indexPath row]];
    
    [self.navigationController pushViewController:[[MeetingDetailsViewController alloc] initWithMeeting:meeting] animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1)
        return 103;
    return 20;
}
#pragma mark AddSportDelegate

-(void) sportSelected:(Sport *)sport
{
    if (![sport.name  isEqualToString:@"Tous les sports"])
    {
        [self.member.categories addObject:sport];
    }
    else
    {
        [self.member.categories removeAllObjects];
    }
    
    [[self memberView].sportsTableView reloadData];
    
    NSIndexPath* ipath = [NSIndexPath indexPathForRow:([self.member.categories count] -1) inSection:0];
    [[self memberView].sportsTableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionBottom animated: YES];
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
