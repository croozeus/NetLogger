//
//  NetLogger
//
//  Created by Pankaj Nathani on 08/05/18.
//


#import <UIKit/UIKit.h>

@protocol NLWindowDelegate;

@interface NLWindow : UIWindow

@property (nonatomic, weak) id <NLWindowDelegate> eventDelegate;

@end

@protocol NLWindowDelegate <NSObject>

- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow;

@end
