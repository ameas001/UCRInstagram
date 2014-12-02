//
//  LoginViewController.m
//  UCRInstagram
//
//  Created by Tony Albor on 1/25/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end


@implementation LoginViewController
@synthesize userlogText;
@synthesize passlogText;
@synthesize loginButton;
@synthesize lbackButton;

- (IBAction)userlogTextAction:(id)sender {
    NSLog(@"username");
}
- (IBAction)passlogTextAction:(id)sender {
    NSLog(@"password");
}
- (IBAction)loginAction:(id)sender {
    NSLog(@"login");
    [userlogText resignFirstResponder];
    [passlogText resignFirstResponder];
    
    [PFUser logInWithUsernameInBackground:userlogText.text password:passlogText.text block:^(PFUser *user, NSError *error) {
        if(user){
            //Successful log in
            NSLog(@"works");
            UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
            UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"TabViewController"];
            [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
            [self presentViewController:lvc animated:YES completion:nil];
        }
        else
        {
            //Error login in
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"Please enter your correct username and password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
}];
}

- (IBAction)backAction:(id)sender {
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //When you hit return on keyboard dismisses keyboard
    [textField resignFirstResponder];
    return NO;
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
    
    //When the user hits return, dismisses keyboard
    self.userlogText.delegate = self;
    self.passlogText.delegate = self;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserlogText:nil];
    [self setPasslogText:nil];
    [self setLoginButton:nil];
    [super viewDidUnload];
}
@end
