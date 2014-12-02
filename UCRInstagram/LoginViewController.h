//
//  LoginViewController.h
//  UCRInstagram
//
//  Created by Tony Albor on 1/25/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userlogText;
@property (weak, nonatomic) IBOutlet UITextField *passlogText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *lbackButton;


@end
