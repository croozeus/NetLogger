//
//  RequestsViewController.h
//  Playground
//
//  Created by Pankaj Nathani on 07/05/18.
//  Copyright © 2018 Pankaj Nathani. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NLBaseViewController.h"

@interface NLRequestDetailViewController : NLBaseViewController<UITableViewDelegate, UITableViewDataSource>

@property NSURLRequest* request;
@property NSDictionary* responseDict;
@property NSString* reqId;

@end
