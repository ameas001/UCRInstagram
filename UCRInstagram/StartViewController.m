//
//  StartViewController.m
//  UCRInstagram
//
//  Created by Mandeep Singh on 1/30/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "StartViewController.h"

@interface StartViewController ()

@end

@implementation StartViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"TabViewController"];
        [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:lvc animated:YES completion:nil];
    } else {
        // show the signup or login screen
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"GreetingViewController"];
        [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
        [self presentViewController:lvc animated:YES completion:nil];    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
