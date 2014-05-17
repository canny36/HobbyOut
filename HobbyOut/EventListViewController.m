//
//  EventListViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 21/04/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "EventListViewController.h"
#import "EventListView.h"
#import "IIViewDeckController.h"
#import "EventCell.h"

#import "SearchViewController.h"

#import "ActionSheetDatePicker.h"

#import "Meeting.h"
#import "MeetingDetailsViewController.h"
#import "Sport.h"

#import <CoreLocation/CoreLocation.h>

@interface EventListViewController ()<MeetingsServiceDelegate, CLLocationManagerDelegate>
{
    NSDictionary *_meetingByCategory;
    NSArray *_categoryArray;
    CLLocationManager *_locationManager;
    CLLocation  *_location;
    NSDate *_displayedDate;
}
@end

@implementation EventListViewController

- (id)init{
    self = [super init];
    if (self) {

        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
        [leftButton setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView)
             forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
        [searchButton setImage:[UIImage imageNamed:@"searchIcon"] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(_displaySearch)
             forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];

        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navbar-logo.png"]];
        
        self.meetingsServices = [[MeetingsService alloc] initWithDelegate:self];
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(_refreshView:) forControlEvents:UIControlEventValueChanged];
        
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
        
         _displayedDate = [NSDate date];

        
    }
    return self;
}



- (void)loadView
{
    self.view = [[EventListView alloc] init];
    [self eventListView].eventTableView.delegate = self;
    [self eventListView].eventTableView.dataSource = self;
    
    [[self eventListView].calendarButton addTarget:self action:@selector(_displayCalendar:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self eventListView].eventTableView addSubview:self.refreshControl];
    
    [[self eventListView].searchButton addTarget:self action:@selector(_displaySearch) forControlEvents:UIControlEventTouchUpInside];
}

-(EventListView *) eventListView
{
    return  (EventListView *)self.view;
}


-(void) _displaySearch
{
    [self.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
}

-(void) _displayCalendar  :(UIControl *)sender
{
    ActionSheetDatePicker *actionDatePicker = [ActionSheetDatePicker showPickerWithTitle:@"Evènements du :"
                                                                          datePickerMode:UIDatePickerModeDate
                                                                            selectedDate:_displayedDate
                                                                                  target:self
                                                                                  action:@selector(_dateWasSelected:element:)
                                                                                  origin:sender];
    UIDatePicker *datePicker = (UIDatePicker *)actionDatePicker.pickerView;
    datePicker.minimumDate = [NSDate date];
    datePicker.maximumDate = [datePicker.minimumDate dateByAddingTimeInterval:60*60*24*14];
}

-(NSDictionary *) _createParams
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    [params setObject:[dateFormatter stringFromDate:_displayedDate] forKey:@"date"];
    
    if (_location.coordinate.latitude != 0)
        [params setObject:[NSString stringWithFormat:@"%f",_location.coordinate.latitude] forKey:@"lat"];
    
    if (_location.coordinate.longitude != 0)
        [params setObject:[NSString stringWithFormat:@"%f",_location.coordinate.longitude] forKey:@"lng"];
    
    return params;
}

- (void)_dateWasSelected:(NSDate *)selectedDate element:(id)element {
    _displayedDate = selectedDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd MMMM yyyy"];
    
    NSString *dateLabel = [dateFormatter stringFromDate:_displayedDate];
    
    NSDate *now = [NSDate date];
    if ([dateLabel isEqualToString:[dateFormatter stringFromDate:now]])
        [self eventListView].dateLabel.text = @"AUJOURD'HUI";
    else if ([dateLabel isEqualToString:[dateFormatter stringFromDate:[now dateByAddingTimeInterval:60*60*24]]])
        [self eventListView].dateLabel.text = @"DEMAIN";
    else
        [self eventListView].dateLabel.text = dateLabel;
    
    
    [self _refreshData];
}

- (void) _refreshView:(UIRefreshControl *)sender {
    [self.meetingsServices getWithParameters:[self _createParams]];
}

-(void) _refreshData
{
    [self.meetingsServices getWithParameters:[self _createParams] forView:self.view];
    [_locationManager stopMonitoringSignificantLocationChanges];
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

#pragma mark MeetingsServiceDelegate

- (void) meetingsRetrieved:(MeetingsService*) service meetingByCategory:(NSDictionary *) meetingByCategory andCategoryArray:(NSArray *)categoryArray
{
    _meetingByCategory = meetingByCategory;
    _categoryArray = categoryArray;
    [[self eventListView].eventTableView reloadData];
    [[self eventListView].eventTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    [self.refreshControl endRefreshing];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger count = [_categoryArray count];
    
    if (_meetingByCategory && count == 0)
        [self eventListView].noDataFrame.hidden = NO;
    else
        [self eventListView].noDataFrame.hidden = YES;
    
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [_categoryArray objectAtIndex:section];
    
    return [[_meetingByCategory objectForKey:key] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"EVENT_CELL";
    EventCell *cell = (EventCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[EventCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
