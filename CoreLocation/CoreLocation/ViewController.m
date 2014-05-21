//
//  ViewController.m
//  CoreLocation
//
//  Created by iC on 5/20/14.
//  Copyright (c) 2014 in.notes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) MKLocalSearchResponse *response;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)setResponse:(MKLocalSearchResponse *)response
{
    if (_response != response) {
        _response = response;
        
        // As soon as _response is set, reloading tableView.
        [self.searchDisplayController.searchResultsTableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Allocating and setting up our locationManager.
    // For more information on distanceFilter, desiredAccuracy, see docs.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10.0;
    self.locationManager.desiredAccuracy = 5;
    
    // Telling our location manager to start updating location.
    // Make sure you stop updating location if your app does not require constants updates.
    [self.locationManager startUpdatingLocation];
}

#pragma mark - LocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = locations.lastObject;
    CLLocationCoordinate2D cooridnate = location.coordinate;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(cooridnate, 1000, 1000);
    
    [self.mapView setRegion:region animated:YES];
}

#pragma mark - Search Bar Delegate

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    
    [request setRegion:self.mapView.region];
    [request setNaturalLanguageQuery:searchBar.text];
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES]; // Starting spinner in the status bar.
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO]; // Stopping and hiding spinner in the status bar.
        
        if (error) {
            NSLog(@"%@",[error localizedDescription]); return;
        }
        
        if (!response.mapItems.count) {
            NSLog(@"No Results Found"); return;
        }
        
        self.response = response;
        
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.response.mapItems count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    MKMapItem *item = self.response.mapItems[indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.placemark.addressDictionary[@"Street"];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchDisplayController setActive:NO animated:YES];
    [self.mapView addAnnotation:[self.response.mapItems[indexPath.row]placemark]];
    
    // ^ Keep in mind, if the place you selected is outside of the map region, you'll need to zoom out to see it or implement a method that does that automatically.
}

@end
