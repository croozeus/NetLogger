//
//  OverlayViewController.m
//  Playground
//
//  Created by Pankaj Nathani on 07/05/18.
//  Copyright © 2018 Pankaj Nathani. All rights reserved.
//

#import "NLOverlayViewController.h"
#import "NLRequestListViewController.h"
#import "NLConstants.h"

@interface NLOverlayViewController ()
@property (weak, nonatomic) IBOutlet UIButton *toolButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolButtonLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolButtonTopConstraint;

@end

@implementation NLOverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSBundle *podBundle = [NSBundle bundleForClass:[self class]];

    self.view.backgroundColor = [UIColor clearColor];
    [self.toolButton setImage:[UIImage imageNamed:@"network" inBundle:podBundle compatibleWithTraitCollection:nil] forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setAlignment:self.position];
    


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
            self.toolButton.backgroundColor = [UIColor yellowColor];

    });
}
- (void) resUpdated:(NSNotification *) notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
            self.toolButton.backgroundColor =[UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1.0];
    });
}


- (void)setAlignment:(NetLoggerAlign)position{
    
    self.toolButtonLeftConstraint.constant = ([[UIScreen mainScreen] bounds].size.width /2) - (self.toolButton.frame.size.width/2);
    
    self.toolButtonTopConstraint.constant = ([[UIScreen mainScreen] bounds].size.height /2) - (self.toolButton.frame.size.height/2);
    
    
    
    if (position == ALIGN_LEFT)
    {
        self.toolButtonLeftConstraint.constant =   0 ;
    }
    else if (position == ALIGN_RIGHT)
    {
        self.toolButtonLeftConstraint.constant = [[UIScreen mainScreen] bounds].size.width  - self.toolButton.frame.size.width;
    }
    else if (position == ALIGN_TOP)
    {
        self.toolButtonTopConstraint.constant = 0;
    }
    else if (position == ALIGN_BOTTOM)
    {
        self.toolButtonTopConstraint.constant = [[UIScreen mainScreen] bounds].size.height - self.toolButton.frame.size.height;
    }
    
}

- (IBAction)buttonPressed:(id)sender {
    NSBundle *podBundle = [NSBundle bundleForClass:[NLRequestListViewController class]];

    NLRequestListViewController* rVC = [[NLRequestListViewController alloc] initWithNibName:@"NLRequestsViewController" bundle:podBundle];
    [self presentViewController:rVC animated:YES completion:nil];
    
}



- (BOOL)shouldHandleTouchAtPoint:(CGPoint)pointInWindow{
    if (CGRectContainsPoint(self.toolButton.frame, pointInWindow))

    {
        return YES;
    }
    return NO;
}


@end
