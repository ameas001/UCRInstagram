//
//  ExploreViewController.h
//  UCRInstagram
//
//  Created by Tony Albor on 2/14/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

//Data to be sent to enhanced view
NSString *user_text;
UIImage *pass_image;
NSString *pass_desc;
NSString *pass_date;
PFObject *pass_imageobject;
bool camefrom;
NSMutableArray *global_images;

@interface ExploreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;
@property (weak, nonatomic) IBOutlet UIButton *button6;
@property (weak, nonatomic) IBOutlet UIButton *button7;
@property (weak, nonatomic) IBOutlet UIButton *button8;
@property (weak, nonatomic) IBOutlet UIButton *button9;
@property (weak, nonatomic) IBOutlet UIButton *refreshButton;
-(NSString*)getName;
-(UIImage*)getImage;
-(NSString*)getDesc;
-(NSString*)getDate;
-(PFObject*)getImageObject;
-(bool)getComefrom;
-(void)setCame;
-(void)sendInfo:(int)i;


@end