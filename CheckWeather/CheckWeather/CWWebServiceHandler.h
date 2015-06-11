//
//  CWWebServiceHandler.h
//  CheckWeather
//
//  Created by Vivek Nahar .
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, HTTPMethod){
    HTTPMethodPost,
    HTTPMethodGet
};

@interface CWWebServiceHandler : NSObject
{
    NSURLSession *_session;
    

}
@property (strong,nonatomic)NSURLSessionConfiguration *sessionConfiguration;

/*!
 @method        initConnectionWithUrl:method:completionHandler:failure:
 @abstract      This method create and handle the request and returns the success/failure response.
 @param         aUrlString -  Source url where data has to be fetched.
 @param         httpMethod - GET or POST
 */
-(void)initConnection:(NSString *)urlString method:(HTTPMethod)httpMethod
    completionHandler:(void(^)(NSData *data,NSHTTPURLResponse *response ))success
              failure:(void(^)(NSError *error))failure;
@end
