//
//  PictureViewController.h
//  UCRInstagram
//
//  Created by user2349 on 2/8/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>

//Data to be sent to the enhanced view
NSString *user_text;
UIImage *pass_image;
NSString *pass_desc;
NSString *pass_date;
PFObject *pass_imageobject;
bool camefrom;

@interface PictureViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate>
{
    UIImagePickerController *imagePicker;
    UIImage *profilePic;
    bool useCamera;
    NSString *visibleEveryone;
    CLLocationManager *locationMan;
    CLLocation *local;
    NSString *userCity;
    NSString *userState;
    
}
-(NSString*)getName;
-(UIImage*)getImage;
-(NSString*)getDesc;
-(NSString*)getDate;
-(PFObject*)getImageObject;
-(bool)getComefrom;
-(void)setCame;

//Reset Filter
-(void)resetFilter;

@property (weak, nonatomic) IBOutlet UITextView *descText;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *imageTakeButton;
@property (weak, nonatomic) IBOutlet UIButton *visibleButton;

//Filter buttons
@property (weak, nonatomic) IBOutlet UIButton *normalButton;
@property (weak, nonatomic) IBOutlet UIButton *sepiaButton;
@property (weak, nonatomic) IBOutlet UIButton *sharpenButton;
@property (weak, nonatomic) IBOutlet UIButton *b52Button;
@property (weak, nonatomic) IBOutlet UIButton *monoButton;




@end
