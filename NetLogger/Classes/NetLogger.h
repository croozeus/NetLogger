//
//  NetLogger.h
//  NetLogger
//
//  Created by Pankaj Nathani on 08/05/18.
//

#import <Foundation/Foundation.h>
#import "NLWindow.h"
#import "NLBaseViewController.h"

@interface NetLogger : NSObject<NLWindowDelegate>

+ (id)sharedManager;

- (void)show:(NetLoggerAlign)position;

@end
