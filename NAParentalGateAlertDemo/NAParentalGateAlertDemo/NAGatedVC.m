//
//  NAGatedVC.m
//  NAParentalGateAlertDemo
//
//  Created by Nathan Rowe on 9/30/13.
//  Copyright (c) 2013 Natrosoft LLC. All rights reserved.
//

#import "NAGatedVC.h"

@interface NAGatedVC ()

@end

@implementation NAGatedVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)userWantsToGoBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
