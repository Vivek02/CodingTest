//
//  ViewController.h
//  CheckWeather
//
//  Created by Vivek Nahar.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationManager.h"
#import "CWWebServiceHandler.h"
@class LocationManager;
@class CWWebServiceHandler;

@interface ViewController : UIViewController<LocationManagerDelegate,UITableViewDelegate, UITableViewDataSource>
{
    
    
    NSMutableArray *arrayCurrent,*arrayhourly,*arrayDaily;
}

-(void)callWeatherResult;
@end

