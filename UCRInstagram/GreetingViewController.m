//
//  GreetingViewController.m
//  UCRInstagram
//
//  Created by user2349 on 1/26/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "GreetingViewController.h"
#import "LoginViewController.h"
#import "SignUpViewController.h"

@interface GreetingViewController ()

@end

@implementation GreetingViewController
@synthesize logButton;
@synthesize signButton;

- (IBAction)logButtonActoin:(id)sender {
   
}
- (IBAction)signButtonAction:(id)sender {
    
}

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
	// Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
