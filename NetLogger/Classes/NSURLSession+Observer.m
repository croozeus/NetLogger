//
//  NetworkObserver.m
//  Playground
//
//  Created by Pankaj Nathani on 07/05/18.
//  Copyright © 2018 Pankaj Nathani. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSURLSession+Observer.h"
#import <objc/runtime.h>
#import "NetRecorder.h"

@implementation NSURLSession (Observer)

+ (void) load{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        
        SEL defaultSelector = @selector(dataTaskWithRequest:completionHandler:);
        SEL swizzledSelector = @selector(mdataTaskWithRequest:completionHandler:);
        
        Method defaultMethod = class_getInstanceMethod(class, defaultSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL isMethodExists = !class_addMethod(class, defaultSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (isMethodExists) {
            method_exchangeImplementations(defaultMethod, swizzledMethod);
        }
        else {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(defaultMethod), method_getTypeEncoding(defaultMethod));
        }
    });
}

- (NSURLSessionDataTask *)mdataTaskWithRequest:(NSURLRequest *)request completionHandler:(void (^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler{
    
    NSTimeInterval  requestTime = [[NSDate date] timeIntervalSince1970];
    __block NSString *requestTimeString = [NSString stringWithFormat:@"%f", requestTime];
    
    [[NetRecorder sharedManager] recordRequest:request forReqId:requestTimeString];
    
    return [self mdataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse *response, NSError *  error) {
        if (completionHandler)
        {
            completionHandler(data, response, error);
        }
        NSTimeInterval  respTime = [[NSDate date] timeIntervalSince1970];
        __block NSString *respTimeString = [NSString stringWithFormat:@"%f", respTime];
        [[NetRecorder sharedManager] recordResponse:response withData:data withError:error forReqId:requestTimeString forResId:respTimeString];
    }];
}


@end
