//
//  EditProfileViewController.h
//  UCRInstagram
//
//  Created by Tony Albor on 2/14/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ProfileViewController.h"

@interface EditProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *editNameTextField;
@property (weak, nonatomic) IBOutlet UITextView *editAboutMeUITV;
@property (nonatomic) PFUser *currentUser;


- (IBAction)doneEditing2:(id)sender;
@end
