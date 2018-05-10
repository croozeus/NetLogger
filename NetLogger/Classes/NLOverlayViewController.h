//
//  OverlayViewController.h
//  Playground
//
//  Created by Pankaj Nathani on 07/05/18.
//  Copyright © 2018 Pankaj Nathani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLBaseViewController.h"

@interface NLOverlayViewController : NLBaseViewController

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow;
- (void)setAlignment:(NetLoggerAlign)position;
@property NetLoggerAlign position;

@end
