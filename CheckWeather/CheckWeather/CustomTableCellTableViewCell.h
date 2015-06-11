//
//  CustomTableCellTableViewCell.h
//  CheckWeather
//
//  Created by Vivek Nahar on 6/11/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableCellTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *summaryLabel;
@property (nonatomic, weak) IBOutlet UILabel *humidityLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;

@end
