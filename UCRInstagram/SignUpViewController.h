//
//  SignUpViewController.h
//  UCRInstagram
//
//  Created by Tony Albor on 1/25/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface SignUpViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate, UIPickerViewDataSource, UITextFieldDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *profilePic;
    bool useCamera;
    NSDate *datepicked;
    UIActionSheet *datesheet;
    
    NSArray *genderArray;
    UIPickerView *genderPickerView;
    
    IBOutlet UIDatePicker *birthdayPicker;
    
    UIToolbar *doneAccessoryView;
    
    
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (weak, nonatomic) IBOutlet UITextField *genderTextField;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIButton *sbackButton;
@property (strong, nonatomic) IBOutlet UIButton *photoButton;


//-(void)setBirth;
//-(void)dismissDateSet;
//-(void)cancelDateSet;

@end

