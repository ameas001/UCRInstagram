//
//  SignUpViewController.m
//  UCRInstagram
//
//  Created by Tony Albor on 1/25/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignUpViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface SignUpViewController ()

@end


@implementation SignUpViewController
@synthesize userNameTextField;
@synthesize passwordTextField;
@synthesize nameTextField;
@synthesize emailTextField;
@synthesize genderTextField;
@synthesize signUpButton;
@synthesize sbackButton;
@synthesize photoButton;

 
- (IBAction)userNameTextAction:(id)sender {
    NSLog(@"username works");
}
- (IBAction)passwordTextAction:(id)sender {
    NSLog(@"password works");
}
- (IBAction)nameTextAction:(id)sender {
    NSLog(@"Name works");
}
- (IBAction)emailTextAction:(id)sender {
    NSLog(@"Email works");
}
- (IBAction)birthdayTextAction:(id)sender {
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //When you hit return on keyboard dismisses keyboard
    [textField resignFirstResponder];
    return NO;
}


- (IBAction)photoButtonAction:(id)sender {
    //WARNING here but it still works idk
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Change Profile Picture" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Choose from Library", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //Starts at the top (Take photo=0, choose=1, cancel=2)
    if(buttonIndex == 0){
        //take photo
        [self startCameraControllerFromViewController: self
                                        usingDelegate: self];
        useCamera = YES;
    }
    if(buttonIndex == 1){
        //choose from library using image picker controller
        NSLog(@"choose");
        imagePicker.delegate=self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        useCamera = NO;
        [self presentModalViewController:imagePicker animated:YES];
        
    }
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate,
                                                   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =[NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];       
    // Allow editing
    cameraUI.allowsEditing = YES;
    
    cameraUI.delegate = delegate;
    
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Finish picking photo from library
    UIImage *photo_pick;
    NSURL *mediaURL;
    mediaURL = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
    photo_pick = (UIImage *)[info valueForKey:UIImagePickerControllerEditedImage];
    //save image to global
    profilePic = photo_pick;
    if(useCamera){
        UIImageWriteToSavedPhotosAlbum (profilePic, nil, nil , nil);
    }
    [photoButton setImage:photo_pick forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //Dismiss MVC for imagepicker
    [picker dismissModalViewControllerAnimated:YES];
}
- (IBAction)signUpButtonAction:(id)sender {
    NSLog(@"signupbutton works");
    [passwordTextField resignFirstResponder];
    [userNameTextField resignFirstResponder];
    [nameTextField resignFirstResponder];
    [emailTextField resignFirstResponder];
    
    //Check to see if username, password, and email have text
    if([emailTextField.text length]!=0 && [userNameTextField.text length]!=0 && [passwordTextField.text length]!=0 && [_birthdayTextField.text length]!=0 && [genderTextField.text length]!=0)
    {
        NSLog(@"EMEME");
        //Create user with lower string name.
        PFUser *user = [PFUser user];
        user.username = [userNameTextField.text lowercaseString];
        user.password = passwordTextField.text;
        user.email = emailTextField.text;
        
        [user setObject:[_dateFormatter dateFromString:_birthdayTextField.text] forKey:@"Birthday"];
        [user setObject:genderTextField.text forKey:@"gender"];
        
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if(!error) {
                //User was successfully created
                //Set other fields: name, gender, birthday, profile pic
                [user setObject:nameTextField.text forKey:@"name"];
                //Saving profile pic
                NSData *ppData = UIImagePNGRepresentation(profilePic);
                PFFile *ppFile = [PFFile fileWithName:@"profilepic" data:ppData];
                [ppFile save];
                [user setObject:ppFile forKey:@"profilePic"];
                
                UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
                UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"TabViewController"];
                [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
                [self presentViewController:lvc animated:YES completion:nil];
            } else {
                //There was error when creating the user, either email or username were taken
                NSString *err_msg = [[error userInfo] objectForKey:@"error"];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:err_msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
    else
    {
        NSString *err_msg = @"Please enter a username, password, email, birthday, and gender.";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Registration Failed" message:err_msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
}
- (IBAction)sbackAction:(id)sender {
    
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
    //for the image picker
    imagePicker = [[UIImagePickerController alloc]init];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    _dateFormatter = [[NSDateFormatter alloc] init];
    [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [_dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    doneAccessoryView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    doneAccessoryView.barStyle = UIBarStyleBlackTranslucent;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneTapped:)];
    NSArray *items = [NSArray arrayWithObjects:space,done,nil];
    doneAccessoryView.items = items;
    
    //When you hit return on the keyboard it dismisses the keyboard
    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.nameTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.birthdayTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserNameTextField:nil];
    [self setPasswordTextField:nil];
    [self setSignUpButton:nil];
    [self setBirthdayTextField:nil];
    [self setGenderTextField:nil];
    [super viewDidUnload];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;//(pickerView == genderPickerView ? 1 : 3);
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    //NSArray *values = (pickerView == genderPickerView ? genderArray : birthdayArray);
    return [genderArray count] ;//]values count];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //UITextField *textField = (pickerView == genderPickerView ? _genderTextField : _birthdayTextField);
    //NSArray *array= (pickerView == genderPickerView ? genderArray : birthdayArray);
    //textField.text = [array objectAtIndex:row];
    genderTextField.text = [genderArray objectAtIndex:row];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    //NSArray *array= (pickerView == genderPickerView ? genderArray : birthdayArray);
    return [genderArray objectAtIndex:row];
}
- (IBAction)editingGender:(id)sender {
    NSLog(@"genderTextField tapped");
    [self createGenderPickerView];
}

-(void)createGenderPickerView
{
    genderPickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    
    genderTextField.inputAccessoryView = doneAccessoryView;
    
    genderArray = [[NSArray alloc]initWithObjects:@"-",@"Male",@"Female", nil];
    
    genderTextField.inputView = genderPickerView;
    genderPickerView.delegate = self;
    genderPickerView.showsSelectionIndicator = YES;
    
    [self.view addSubview:genderPickerView];
}

- (IBAction)birthdayEditing:(id)sender {
    [self createBirthdayPicker];
    NSLog(@"editing birthday");
}

-(void)createBirthdayPicker
{
    if ([_birthdayTextField.text length] <= 0 ||_birthdayTextField.text == nil || [_birthdayTextField.text isEqual:@""] == TRUE)
    {
        _birthdayTextField.text = [_dateFormatter stringFromDate:[NSDate date]];
    }
    
    birthdayPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    birthdayPicker.datePickerMode = UIDatePickerModeDate;
    birthdayPicker.date = [_dateFormatter dateFromString:_birthdayTextField.text];
    
    _birthdayTextField.inputAccessoryView = doneAccessoryView;
    _birthdayTextField.inputView = birthdayPicker;
    
    [birthdayPicker addTarget:self
                       action:@selector(LabelChange:)
             forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:birthdayPicker];
}

- (void)LabelChange:(id)sender
{
    _birthdayTextField.text = [_dateFormatter stringFromDate:birthdayPicker.date];
}

-(void)doneTapped:(id)sender
{
    [birthdayPicker removeFromSuperview];
    [genderPickerView removeFromSuperview];
    [genderTextField resignFirstResponder];
    [_birthdayTextField resignFirstResponder];
}

@end
