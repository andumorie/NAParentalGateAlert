//
//  NAViewController.m
//  NAParentalGateAlertDemo
//
//  Created by Nathan Rowe on 9/30/13.
//  Copyright (c) 2013 Natrosoft LLC. All rights reserved.
//

#import "NAViewController.h"
#import "NAParentalGateAlert.h"
#import "NAGatedVC.h"

@interface NAViewController ()

@end

@implementation NAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)userWantsToAccessGatedView:(id)sender
{
    [[NAParentalGateAlert alertWithAction:^{
        NAGatedVC *gatedVC = [[NAGatedVC alloc] initWithNibName:@"NAGatedVC" bundle:nil];
        [self presentViewController:gatedVC animated:YES completion:nil];
    }] show];
}

@end
