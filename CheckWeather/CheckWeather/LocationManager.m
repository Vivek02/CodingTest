//
//  LocationManager.m
//  CheckWeather
//
//  Created by Vivek Nahar.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import "LocationManager.h"
#import "ConstantUrl.h"

@implementation LocationManager
@synthesize locationManager;
@synthesize delegate;
- (id)init
{
    self = [super init];
    if (self)
    {
        [self getMyCurrentLocation];
    }
    
    return self;
}

-(void)getMyCurrentLocation
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    if(IS_OS_8_OR_LATER)
    {
        // [self.locationManager requestAlwaysAuthorization];//background Call
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:AlertErrorTitle message:AlertMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
     errorAlert=nil;
    
    self.locationManager .delegate=nil;
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLLocation *currentLocation = newLocation;
    
    if(![[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] isEqualToString:[NSString stringWithFormat:@"%.8f", oldLocation.coordinate.longitude]])
    {
    if (currentLocation != nil)
    {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(myCurrentLatitude:andLongitude:)])
        {
           
            locationManager.delegate=nil;
            [locationManager stopUpdatingLocation];
            [[self delegate] myCurrentLatitude: [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude] andLongitude:[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude]];
           
        }
       
    }
    }
    
}
@end
