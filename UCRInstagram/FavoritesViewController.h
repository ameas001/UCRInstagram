//
//  FavoritesViewController - Favorites.h
//  UCRInstagram
//
//  Created by Luis Roman on 3/6/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Cell.h"

NSString *user_text;
UIImage *pass_image;
NSString *pass_desc;
NSString *pass_date;
PFObject *pass_imageobject;
bool camefrom;

@interface FavoritesViewController : UIViewController
{
    int page;
    NSMutableArray *imageArray;
    NSMutableArray *dateArray;
    NSMutableArray *previewImageArray;
    NSMutableArray *descriptionArray;
    NSMutableArray *userNameArray;
    NSMutableArray *imageobjects;
}

//@property (strong, nonatomic) NSArray *data_array;

//@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UIButton *buttonImage1;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage2;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage3;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage4;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage5;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage6;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage7;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage8;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage9;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage10;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage11;

@property (weak, nonatomic) IBOutlet UIButton *buttonImage12;

@property (weak, nonatomic) IBOutlet UIButton *previous;

@property (weak, nonatomic) IBOutlet UIButton *next;

-(NSString*)getName;
-(UIImage*)getImage;
-(NSString*)getDesc;
-(NSString*)getDate;
-(PFObject*)getImageObject;
-(bool)getComeFrom;
-(void)setCame;
-(void)sendInfo:(int)i;

-(void)reload;

@end