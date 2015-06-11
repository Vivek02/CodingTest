//
//  CWWebServiceHandler.m
//  CheckWeather
//
//  Created by Vivek Nahar .
//  Copyright (c) 2015 TCS. All rights reserved.
//

#import "CWWebServiceHandler.h"

@implementation CWWebServiceHandler
@synthesize sessionConfiguration;
NSString *httpPost = @"POST";
NSString *httpGet = @"GET";

-(void)initConnection:(NSString *)urlString method:(HTTPMethod)httpMethod
    completionHandler:(void(^)(NSData *data,NSHTTPURLResponse *response ))success
              failure:(void(^)(NSError *error))failure
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    
    switch (httpMethod) {
        case HTTPMethodGet:
            urlRequest.HTTPMethod = httpGet;
            break;
        case HTTPMethodPost:
            urlRequest.HTTPMethod = httpPost;
            break;
        default:
            urlRequest.HTTPMethod = httpGet;
            break;
    }
    
    [self downloadDataForRequest:urlRequest completionHandler:^(NSData *data,NSHTTPURLResponse *httpResponse)
     {
         success(data,httpResponse);
     }failure:^(NSError *error)
     {
         failure(error);
     }];
}
-(NSURLSession *)urlSession
{
    NSURLSession *session = nil;
    if(self.sessionConfiguration != nil)
    {
        session = [NSURLSession sessionWithConfiguration:self.sessionConfiguration];
    }
    else
    {
        session = [NSURLSession sharedSession];
    }
    return session;
}

#pragma mark - Data Task

-(void)downloadDataForRequest:(id)urlRequest
            completionHandler:(void(^)(NSData *data,NSHTTPURLResponse *response))success
                      failure:(void(^)(NSError *error))failure
{
    NSURLSession *session = [self urlSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data,NSURLResponse *response,NSError *error){
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(!error)
        {
            success(data,httpResponse);
        }
        else
        {
            failure(error);
        }
    }];
    [dataTask resume];
}

@end
