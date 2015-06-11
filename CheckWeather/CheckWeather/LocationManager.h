//
//  LocationManager.h
//  CheckWeather
//
//  Created by Vivek Nahar .
//  Copyright (c) 2015 TCS. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol LocationManagerDelegate <NSObject>
/*!
 @method        myCurrentLatitude:andLongitude
 @abstract      This delegate method is called when latitude and longitude are get
 @param         latiude and longitude in string formate
 @result        send latitude and longitude value
 */
- (void)myCurrentLatitude:(NSString *)latitude andLongitude:(NSString *)longitude;
@end

@interface LocationManager : NSObject <CLLocationManagerDelegate>
{
     CLLocationManager *locationManager;
}
@property(nonatomic,strong) CLLocationManager *locationManager;
@property(nonatomic,weak) id <LocationManagerDelegate> delegate;
-(void)getMyCurrentLocation;
@end
