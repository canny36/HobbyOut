//
//  MeetingMapViewController.m
//  HobbyOut
//
//  Created by Frédéric DE MATOS on 29/05/13.
//  Copyright (c) 2013 smartfrog. All rights reserved.
//

#import "MeetingMapViewController.h"
#import "MeetingMapView.h"


@interface MeetingMapViewController ()<MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}

@end

@implementation MeetingMapViewController

-(id) initWithTitle:(NSString *) title andPlaceMark:(PlaceMark *) placeMark
{
    self = [super init];
    
    if (self)
    {
        UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        [backButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(_goBack) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.title = title;
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.placemark = placeMark;
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        
        [_locationManager startUpdatingLocation];
    }
    
    return self;
}

-(void) loadView
{
    self.view = [[MeetingMapView alloc] init];
    [[self meetingMapView] setShowsUserLocation:true];
    [self meetingMapView].zoomEnabled = true;
    [self meetingMapView].delegate = self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [[self meetingMapView] addAnnotation:self.placemark];
    [[self meetingMapView] setCenterCoordinate:self.placemark.coordinate animated:true];
    [self _centerOnPlace];
}

-(void) _centerOnPlace
{
    MKCoordinateRegion region;
    region.center.latitude = self.placemark.coordinate.latitude;
    region.center.longitude = self.placemark.coordinate.longitude;
    region.span.latitudeDelta = 0.01;
    region.span.longitudeDelta = 0.01;
    region = [[self meetingMapView] regionThatFits:region];
    [[self meetingMapView] setRegion:region animated:TRUE];
}

-(void) _centerOnUserAnPlace
{

    CLLocationCoordinate2D coordinate = self.placemark.coordinate;
    CLLocationCoordinate2D userLocation = [self meetingMapView].userLocation.location.coordinate;


    if (userLocation.latitude != 0  && userLocation.longitude != 0)
    {
        MKCoordinateSpan locationSpan;
        locationSpan.latitudeDelta = fabsf(userLocation.latitude - coordinate.latitude) * 1.18;
        locationSpan.longitudeDelta = fabsf(userLocation.longitude - coordinate.longitude) * 1.18;
        
        CLLocationCoordinate2D locationCenter;
        locationCenter.latitude = (userLocation.latitude + coordinate.latitude) / 2;
        locationCenter.longitude = (userLocation.longitude + coordinate.longitude) / 2;
        
        MKCoordinateRegion region = MKCoordinateRegionMake(locationCenter, locationSpan);
        MKCoordinateRegion scaledRegion = [[self meetingMapView] regionThatFits:region];
         [[self meetingMapView] setRegion:scaledRegion animated:TRUE];
        
        [_locationManager stopUpdatingLocation];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    static NSString *identifier = @"place";
    
    
    if ([annotation isKindOfClass:[PlaceMark class]]) {
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [[self meetingMapView] dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        annotationView.image=[UIImage imageNamed:((PlaceMark *)annotation).pinMapImageName];
        
        return annotationView;
    }
    
    return nil;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self _centerOnUserAnPlace];
}

-(void) _goBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(MeetingMapView *) meetingMapView
{
    return (MeetingMapView *) self.view;
}

@end
