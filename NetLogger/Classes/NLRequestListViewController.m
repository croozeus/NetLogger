//
//  RequestsViewController.m
//  Playground
//
//  Created by Pankaj Nathani on 07/05/18.
//  Copyright © 2018 Pankaj Nathani. All rights reserved.
//

#import "NLRequestListViewController.h"
#import "NetRecorder.h"
#import "NLRequestDetailViewController.h"
#import "NLConstants.h"

@interface NLRequestListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation NLRequestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reqUpdated:)
                                                 name:NOTI_REQ_UPDATED
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resUpdated:)
                                                 name:NOTI_RESPONSE_UPDATED
                                               object:nil];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_RESPONSE_UPDATED object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NOTI_REQ_UPDATED object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) reqUpdated:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}
- (void) resUpdated:(NSNotification *) notification
{
    [self reqUpdated:notification];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)aboutPressed:(id)sender {
    NSLog(@"aboutPressed");
}

- (IBAction)backPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TableView methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[[NetRecorder sharedManager] requestDict] allKeys] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString* cellIdentifier = @"cell";
    
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(localizedCompare:)];

    
    NSArray* allKeys = [[[[NetRecorder sharedManager] requestDict] allKeys] sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    NSString* reqTime =  [allKeys objectAtIndex:indexPath.row];
    
    NSURLRequest* req = [[[NetRecorder sharedManager] requestDict] objectForKey:reqTime];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",req.HTTPMethod, req.URL.absoluteString ];
    
    double timeInterval = [reqTime doubleValue];
    NSDate * requestDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy HH:mm:ss";
    
    
    cell.detailTextLabel.text = [dateFormatter stringFromDate:requestDate];
    
    UIView* accessoryView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 20, 20)];
    
    accessoryView.layer.cornerRadius = 10;
    accessoryView.clipsToBounds = YES;
    accessoryView.alpha = 0.6;
    
    if ([[[[NetRecorder sharedManager] requestDict] allKeys] containsObject:reqTime])
    {
        NSDictionary* resDict =[[[NetRecorder sharedManager] responseDict] objectForKey:reqTime];
        NSURLResponse* res = [resDict objectForKey:NSStringFromClass ([NSURLResponse class])];
        
        NSHTTPURLResponse* httpReq =(NSHTTPURLResponse*)res ;
        
         if (![httpReq isKindOfClass:[NSNull class]] && httpReq.statusCode >= 200 && httpReq.statusCode < 300)
         {
               accessoryView.backgroundColor = [UIColor greenColor];
         }
         else{
             accessoryView.backgroundColor = [UIColor redColor];
         }
        
    }
    else{
        accessoryView.backgroundColor = [UIColor yellowColor];
    }
    

    cell.accessoryView = accessoryView;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString* const frameworkBundleID  = @"org.cocoapods.NetLogger";
    NSBundle *podBundle =[NSBundle bundleWithIdentifier:frameworkBundleID];
    
    NLRequestDetailViewController* rdVC = [[NLRequestDetailViewController alloc] initWithNibName:@"NLRequestDetailViewController" bundle:podBundle];
    
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:NO selector:@selector(localizedCompare:)];
    
    
    NSArray* allKeys = [[[[NetRecorder sharedManager] requestDict] allKeys] sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    NSString* reqTime =  [allKeys objectAtIndex:indexPath.row];
    
    NSURLRequest* req = [[[NetRecorder sharedManager] requestDict] objectForKey:reqTime];
    
    rdVC.request = req;
    rdVC.responseDict =[[[NetRecorder sharedManager] responseDict] objectForKey:reqTime];
    rdVC.reqId = reqTime;
    
    [self presentViewController:rdVC animated:YES completion:nil];
    
}

@end
