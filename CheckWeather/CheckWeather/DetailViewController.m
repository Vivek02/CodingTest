//
//  DetailViewController.m
//  CheckWeather
//
//  Created by Vivek Nahar .
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.humidityLabel.text=self.strhumidity;
    self.summaryLabel.text=self.strSummary;
    self.dateLabel.text=self.strDate;
    if([self.strSummary isEqualToString:@"Weather Drizzel"])
    {
        [self.imgView setImage:[UIImage imageNamed:@"cloudy.jpg"]];
    }
    else if([self.strSummary isEqualToString:@"Weather Light Rain"])
    {
        [self.imgView setImage:[UIImage imageNamed:@"Rainy.jpg"]];
    }
    else if([self.strSummary isEqualToString:@"Weather Overcast"])
    {
        [self.imgView setImage:[UIImage imageNamed:@"cloudy.jpg"]];
    }
    else if([self.strSummary isEqualToString:@"Weather Rain"])
    {
        [self.imgView setImage:[UIImage imageNamed:@"Rainy.jpg"]];
    }
    else if([self.strSummary isEqualToString:@"Weather Clear"])
    {
        [self.imgView setImage:[UIImage imageNamed:@"Sunny.png"]];
    }
    else if([self.strSummary isEqualToString:@"Weather Partly Cloudy"])
    {
        [self.imgView setImage:[UIImage imageNamed:@"Clear.jpg"]];
    }
    else{
        [self.imgView setImage:[UIImage imageNamed:@"Rainy.jpg"]];
    }
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
