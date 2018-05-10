//
//  NetRecorder.h
//  NetRecorder
//
//  Created by Pankaj Nathani on 08/05/18.
//

#import <Foundation/Foundation.h>

@interface NetRecorder : NSObject

@property NSMutableDictionary* requestDict;
@property NSMutableDictionary* responseDict;

+ (id)sharedManager;

- (void)recordRequest:(NSURLRequest*)request forReqId:(NSString*)reqId;
- (void)recordResponse:(NSURLResponse*) response withData:(NSData*)data withError:(NSError*)error forReqId:(NSString*)reqId forResId:(NSString*)resId;



@end
