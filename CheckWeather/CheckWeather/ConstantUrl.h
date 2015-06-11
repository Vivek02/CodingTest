//
//  ConstantUrl.h
//  CheckWeather
//
//  Created by Vivek Nahar on 6/10/15.
//  Copyright (c) 2015 TCS. All rights reserved.
//

#ifndef CheckWeather_ConstantUrl_h
#define CheckWeather_ConstantUrl_h

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define AlertErrorTitle @"Error"
#define AlertMessage @"Failed to Get Weather in Your Device."
#define Weather_Url @"https://api.forecast.io/forecast/%@/%@,%@"
#define Weather_API_Key @"bed275314dcfe5e9b020cf5a55f873b0"
#endif
