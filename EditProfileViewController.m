//
//  EditProfileViewController.m
//  UCRInstagram
//
//  Created by Tony Albor on 2/14/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

-(void)returnToProfile {
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UITabBarController *profile = [st instantiateViewControllerWithIdentifier:@"TabViewController"];
    
    [profile setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:profile animated:YES completion:nil];
    [profile setSelectedIndex:2];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //When you hit return on keyboard dismisses keyboard
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)cancelEditing:(id)sender {
    //[self returnToProfile];
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)doneEditing2:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    
    if(_editNameTextField.text.length == 0) {
        // no edit was made to the text field
        NSLog(@"no edit was made to name");
    } else {
        // input was entered to edit name
        NSLog(@"edit was made to name");
        [currentUser setObject:_editNameTextField.text forKey:@"name"];
    }
    
    if(_editAboutMeUITV.text.length == 0){
        //No edit was made to the text field
    }
    else{
        //Edit was made
        [currentUser setObject:_editAboutMeUITV.text forKey:@"aboutMe"];
    }
    
    [currentUser saveInBackground];
    
    [currentUser refreshInBackgroundWithBlock:nil];
    
    [self returnToProfile];
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
    NSLog(@"CUrrent User: %@",self.currentUser.username);
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEditNameTextField:nil];
    [self setEditAboutMeUITV:nil];
    [super viewDidUnload];
}
@end
