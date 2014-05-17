//
//  SearchViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 30/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchView.h"
#import "SearchEventCell.h"
#import "MeetingDetailsViewController.h"
#import "MBProgressHUD.h"
#import "Sport.h"

#import <CoreLocation/CoreLocation.h>
@interface SearchViewController ()<UISearchBarDelegate, MeetingsServiceDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>
{
    NSDictionary *_meetingByCategory;
    NSArray *_categoryArray;
    CLLocationManager *_locationManager;
    CLLocation  *_location;
}

@end

@implementation SearchViewController

-(id) init
{
    self = [super init];
    
    if (self)
    {
        
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(_goBack) forControlEvents:UIControlEventTouchUpInside];
        
        self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 150, 30)];
        [self.searchBar setBackgroundImage:[UIImage new]];
        [self.searchBar setTranslucent:YES];
        self.searchBar.delegate = self;
        self.searchBar.tintColor = [UIColor whiteColor];
        
        self.navigationItem.titleView = self.searchBar;
        
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.meetingsServices = [[MeetingsService alloc] initWithDelegate:self];
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
    }
    
    return self;
}

-(void) loadView
{
    self.view = [[SearchView alloc] init];
    [self searchView].tableView.delegate = self;
    [self searchView].tableView.dataSource = self;
    
}

-(SearchView *) searchView
{
    return (SearchView *) self.view;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{    
    [searchBar setShowsCancelButton:YES animated:YES];
    
}


-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
	searchBar.text = nil;
	[searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{

    if ([CLLocationManager locationServicesEnabled] && _location == nil)
    {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_locationManager startMonitoringSignificantLocationChanges];
    }
    else
    {
        [self _search];
    }
    
	[searchBar resignFirstResponder];
}



-(void) _goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSDictionary *) _createParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    if (_location.coordinate.latitude != 0)
        [params setObject:[NSString stringWithFormat:@"%f",_location.coordinate.latitude] forKey:@"lat"];
    
    if (_location.coordinate.longitude != 0)
        [params setObject:[NSString stringWithFormat:@"%f",_location.coordinate.longitude] forKey:@"lng"];
    
    [params setObject:_searchBar.text forKey:@"search"];
    
    return params;
}

-(void) _search
{
    [self.meetingsServices getWithParameters:[self _createParams] forView:self.view];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _location = [locations lastObject];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self _search];
    [_locationManager stopMonitoringSignificantLocationChanges];
    
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error
{
    [_locationManager stopMonitoringSignificantLocationChanges];
    NSLog(@"error%@",error);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self _search];
}

#pragma mark MeetingsServiceDelegate

- (void) meetingsRetrieved:(MeetingsService*) service meetingByCategory:(NSDictionary *) meetingByCategory andCategoryArray:(NSArray *)categoryArray
{
    _meetingByCategory = meetingByCategory;
    _categoryArray = categoryArray;
    
    if ([_categoryArray count] == 0)
    {
        [self searchView].noDataFrame.hidden = NO;
    }
    else
    {
        [self searchView].noDataFrame.hidden = YES;
    }
    
    [[self searchView].tableView reloadData];
    [[self searchView].tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger count = [_categoryArray count];
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [_categoryArray objectAtIndex:section];
    
    return [[_meetingByCategory objectForKey:key] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"MEMBER_EVENT_CELL";
    SearchEventCell *cell = (SearchEventCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[SearchEventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    NSString *key = [_categoryArray objectAtIndex:[indexPath section]];
    

    [cell displayEvent:[[_meetingByCategory objectForKey:key] objectAtIndex:[indexPath row]]];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *sport = [_categoryArray objectAtIndex:section];
	UIImageView *headerView = [[UIImageView alloc] initWithImage:[Sport headerFor:sport]];
    
	return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [_categoryArray objectAtIndex:[indexPath section]];
    Meeting *meeting = [[_meetingByCategory objectForKey:key] objectAtIndex:[indexPath row]];
    
    
    [self.navigationController pushViewController:[[MeetingDetailsViewController alloc] initWithMeeting:meeting] animated:TRUE];
}



@end
