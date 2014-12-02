//
//  ProfileViewController.h
//  UCRInstagram
//
//  Created by user2349 on 1/31/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Cell.h"
#import "EditProfileViewController.h"
#import "FriendsViewController.h"

//Data to be sent to the enhanced view
NSString *user_text;
UIImage *pass_image;
NSString *pass_desc;
NSString *pass_date;
PFObject *pass_imageobject;
bool camefrom;

@interface ProfileViewController : UIViewController
{
    int page;
    int pageCounter;
    PFUser *c_user;
    NSMutableArray *imageArray;
    NSMutableArray *dateArray;
    NSMutableArray *previewImageArray;
    NSMutableArray *descriptionArray;
    NSMutableArray *userNameArray;
    NSMutableArray *imageobjects;
}

@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@property (weak, nonatomic) IBOutlet UIImageView *profilepicUI;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UIButton *editProfileButton;
@property (weak, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *aboutMeDescUITV;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage1;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage2;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage3;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage4;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage5;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage6;

@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic) PFUser *currentUser;
@property (nonatomic) NSString *userClickedOn;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *followingButton;

-(NSString*)getName;
-(UIImage*)getImage;
-(NSString*)getDesc;
-(NSString*)getDate;
-(PFObject*)getImageObject;
-(bool)getComefrom;
-(void)setCame;
-(void)sendInfo:(int)i;


-(void)reload;
@end








