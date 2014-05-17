//
//  SearchViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 30/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchView.h"
#import "EventCell.h"
#import "MeetingDetailsViewController.h"
#import "MBProgressHUD.h"

#import <CoreLocation/CoreLocation.h>
@interface SearchViewController ()<UISearchBarDelegate, MeetingsServiceDelegate, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate>
{
    NSDictionary *_meetingByCategory;
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
    [self searchView].delegate = self;
    [self searchView].dataSource = self;
    
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

    if ([CLLocationManager locationServicesEnabled])
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
    [manager stopUpdatingLocation];
    NSLog(@"error%@",error);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self _search];
}

#pragma mark MeetingsServiceDelegate

- (void) meetingsRetrieved:(MeetingsService*) service meetingByCategory:(NSDictionary *) meetingByCategory
{
    _meetingByCategory = meetingByCategory;
    [[self searchView] reloadData];
    [[self searchView] scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger count = [[_meetingByCategory allKeys] count];
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [[_meetingByCategory allKeys] objectAtIndex:section];
    
    return [[_meetingByCategory objectForKey:key] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"EVENT_CELL";
    EventCell *cell = (EventCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *key = [[_meetingByCategory allKeys] objectAtIndex:[indexPath section]];
    
    
    [cell displayEvent:[[_meetingByCategory objectForKey:key] objectAtIndex:[indexPath row]]];
    return cell;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rugbySection"]];
    
	return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [[_meetingByCategory allKeys] objectAtIndex:[indexPath section]];
    Meeting *meeting = [[_meetingByCategory objectForKey:key] objectAtIndex:[indexPath row]];
    
    
    [self.navigationController pushViewController:[[MeetingDetailsViewController alloc] initWithMeeting:meeting] animated:TRUE];
}



@end
