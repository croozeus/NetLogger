//
//  NLViewController.m
//  NetLogger
//
//  Created by croozeus on 05/09/2018.
//  Copyright (c) 2018 croozeus. All rights reserved.
//

#import "NLViewController.h"

@interface NLViewController ()

@end

@implementation NLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

// Timer commented, uncomment if you want to test requests every two seconds
    
//    [NSTimer scheduledTimerWithTimeInterval:2.0
//                                     target:self
//                                   selector:@selector(getReq)
//                                   userInfo:nil
//                                    repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doGETRequest:(id)sender {
    [self getReq];
}

- (void)getReq{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://google.com"]];
    
    [urlRequest setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          NSLog(@"Received GET Response");
          
      }];
    [dataTask resume];
}

- (IBAction)doPOSTRequest:(id)sender {
    [self postReq];
}

- (void) postReq{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://google.com"]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {

          NSLog(@"Received POST Response");
      }];
    [dataTask resume];
}

@end
