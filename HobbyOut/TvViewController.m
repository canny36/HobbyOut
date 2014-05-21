//
//  TvViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 27/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "TvViewController.h"
#import "TvView.h"

#import "IIViewDeckController.h"

#import "TvCell.h"

#import "ActionSheetDatePicker.h"
#import "ActionSheetStringPicker.h"

#import "MeetingViewController.h"

#import "SearchViewController.h"

#import <CoreLocation/CoreLocation.h>

@interface TvViewController ()<EventServiceDelegate, CLLocationManagerDelegate>
{
    NSMutableArray *_tvBroadcastArray;
    NSArray *_source;
    CLLocationManager *_locationManager;
    CLLocation* _location;
    NSDate *_displayedDate;
    NSMutableArray *_sports;
    NSString *_sport;
}


@end

@implementation TvViewController


- (id)init{
    self = [super init];
    if (self) {
        
        
        UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 29)];
        [leftButton setImage:[UIImage imageNamed:@"hamburger.png"] forState:UIControlStateNormal];
        [leftButton addTarget:self.viewDeckController action:@selector(toggleLeftView)
             forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
        
        _sport = @"Tous les sports";
        
        UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 67, 27)];
        [rightButton setImage:[UIImage imageNamed:@"sportFilterButton"] forState:UIControlStateNormal];
        [rightButton addTarget:self action:@selector(_displaySportFilter:)
             forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
        
        self.navigationItem.title = @"AGENDA TV";
        
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(_refreshView:) forControlEvents:UIControlEventValueChanged];
        
        self.eventService = [[EventService alloc] initWithDelegate:self];
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        if ([CLLocationManager locationServicesEnabled])
        {
            [_locationManager startMonitoringSignificantLocationChanges];
        }
        else
        {
            [self _refresData];
        }
        
        _displayedDate = [NSDate date];
        
    }
    return self;
}


-(void) loadView
{
    self.view = [[TvView alloc] init];
    [self tvView].tvTableView.delegate = self;
    [self tvView].tvTableView.dataSource = self;
    [[self tvView].calendarButton addTarget:self action:@selector(_displayCalendar:) forControlEvents:UIControlEventTouchUpInside];
    [self tvView].dateLabel.text = @"AUJOURD'HUI";
    
    [[self tvView].tvTableView addSubview:self.refreshControl];
    
    [[self tvView].searchButton addTarget:self action:@selector(_displaySearch) forControlEvents:UIControlEventTouchUpInside];
}

-(void) _displaySearch
{
    [self.navigationController pushViewController:[[SearchViewController alloc] init] animated:YES];
}

- (void) _refreshView:(UIRefreshControl *)sender {
    [self.eventService getWithParameters:[self _createParams]];
}

-(TvView *) tvView
{
    return (TvView *) self.view;
}


#pragma mark UITableViewDelegate UITableViewDatasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger count = [_tvBroadcastArray count];
    
    if (_tvBroadcastArray && count == 0)
        [self tvView].noDataFrame.hidden = NO;
    else
        [self tvView].noDataFrame.hidden = YES;
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TV_CELL";
    TvCell *cell = (TvCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TvCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell displayTvBroadcast:[_tvBroadcastArray objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TvBroadcast *tvBroadcast = [_tvBroadcastArray objectAtIndex:indexPath.row];
    
    if ([tvBroadcast.meetings count] > 0)
    {
        [self.navigationController pushViewController:[[MeetingViewController alloc] initWithTvBroadcast:tvBroadcast] animated:TRUE];
    }
}

- (void) eventServiceSuccess:(EventService*)eventService  eventArray:(NSArray *) events
{
    _source = events;
    _sports = [NSMutableArray array];
    
    [_sports addObject:@"Tous les sports"];
    for (TvBroadcast *broad in events)
    {
        if ([_sports indexOfObject:broad.sport] == NSNotFound)
            [_sports addObject:broad.sport];
    }
    
    [self _filterData];
}

- (void) _filterData
{
    
    if ([_sport isEqualToString:@"Tous les sports"])
    {
        _tvBroadcastArray = [NSMutableArray arrayWithArray:_source];
    }
     else
     {
         _tvBroadcastArray = [NSMutableArray array];
         
         for (TvBroadcast *broad in _source)
         {
             if ([broad.sport isEqualToString:_sport])
             {
                 [_tvBroadcastArray addObject:broad];
             }
         }
         
     }
    
    [[self tvView].tvTableView reloadData];
    [[self tvView].tvTableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    
    [self.refreshControl endRefreshing];
}

#pragma mark CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    _location = [locations lastObject];
    [self _refresData];
    
}

- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error
{
    [manager stopUpdatingLocation];
    NSLog(@"error%@",error);
    [self _refresData];
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

-(void) _refresData
{
    [self.eventService getWithParameters:[self _createParams] forView:self.view];
    [_locationManager stopMonitoringSignificantLocationChanges];

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


-(void) _displaySportFilter:(UIControl *)sender
{
    [ActionSheetStringPicker showPickerWithTitle:@"Choix du sport" rows:_sports initialSelection:[_sports indexOfObject:_sport] target:self successAction:@selector(_sportWasSelected:element:) cancelAction:nil origin:sender];
}

- (void)_sportWasSelected:(NSNumber *)index element:(id)element {
    _sport = [_sports objectAtIndex:[index integerValue]];
    [self _refresData];
}

- (void)_dateWasSelected:(NSDate *)selectedDate element:(id)element {
    _displayedDate = selectedDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE dd MMMM yyyy"];
    
    NSString *dateLabel = [dateFormatter stringFromDate:_displayedDate];
    
    NSDate *now = [NSDate date];
    if ([dateLabel isEqualToString:[dateFormatter stringFromDate:now]])
        [self tvView].dateLabel.text = @"AUJOURD'HUI";
    else if ([dateLabel isEqualToString:[dateFormatter stringFromDate:[now dateByAddingTimeInterval:60*60*24]]])
        [self tvView].dateLabel.text = @"DEMAIN";
    else
        [self tvView].dateLabel.text = dateLabel;
    

    [self _refresData];
}

@end
