//
//  DetailViewController.h
//  CheckWeather
//
//  Created by Vivek Nahar .
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
{
    
}
@property (nonatomic,strong)NSString *strSummary,*strhumidity,*strDate;
@property (nonatomic, weak) IBOutlet UILabel *summaryLabel;
@property (nonatomic, weak) IBOutlet UILabel *humidityLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@end
