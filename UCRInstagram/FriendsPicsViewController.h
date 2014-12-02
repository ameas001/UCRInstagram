//
//  FriendsPicsViewController.h
//  UCRInstagram
//
//  Created by user2140 on 3/6/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

NSString *user_text;
UIImage *pass_image;
NSString *pass_desc;
NSString *pass_date;
PFObject *pass_imageobject;
bool camefrom;
NSMutableArray *global_images1;

@interface FriendsPicsViewController : UIViewController
{
    int page;
    int pageCounter;
    BOOL firstLoad;
    NSMutableArray *previewImageArray;
    NSMutableArray *imageArray;
    NSMutableArray *dateArray;
    NSMutableArray *descriptionArray;
    NSMutableArray *userNameArray;
    NSMutableArray *imageobjects;
}
@property (weak, nonatomic) IBOutlet UIButton *Refresh;
@property (weak, nonatomic) IBOutlet UIButton *Butt1;
@property (weak, nonatomic) IBOutlet UIButton *Butt2;
@property (weak, nonatomic) IBOutlet UIButton *Butt3;
@property (weak, nonatomic) IBOutlet UIButton *Butt4;
@property (weak, nonatomic) IBOutlet UIButton *Butt5;
@property (weak, nonatomic) IBOutlet UIButton *Butt6;
@property (weak, nonatomic) IBOutlet UIButton *Butt7;
@property (weak, nonatomic) IBOutlet UIButton *Butt8;
@property (weak, nonatomic) IBOutlet UIButton *Butt9;

@property (weak, nonatomic) IBOutlet UIButton *prevButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


-(NSString*)getName;
-(UIImage*)getImage;
-(NSString*)getDesc;
-(NSString*)getDate;
-(PFObject*)getImageObject;
-(bool)getComefrom;
-(void)setCame;
-(void)sendInfo:(int)i;
-(void)downloadImages;
-(void)loadButtons;

@end
