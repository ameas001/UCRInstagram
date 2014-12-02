//
//  DescViewController.h
//  UCRInstagram
//
//  Created by Mandeep Singh on 1/30/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "PictureViewController.h"
#import "ExploreViewController.h"
#import "ProfileViewController.h"
#import "FavoritesViewController.h"

@interface DescViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextInputDelegate>
{
    PFObject *imageobjkeep;
    
    
    //Haos Add-on//////////////////////////////////
    //commentsArray: array grabbed from Parse containing all the comments for the image.
    NSMutableArray * commentsArray;
    
    //visilibityString: string to tell whether or not image is visible to everyone or only friends
    NSString * visibilityString;
    
    //commentSettingString: string to tell if only friends can comment or everyone can.
    NSString * commentSettingString;
    BOOL stayup;
    //////////////////////////////////////////////
}
@property (weak, nonatomic) IBOutlet UITextView *descTextView;
@property (weak, nonatomic) IBOutlet UIImageView *previewImageView;
@property (weak, nonatomic) IBOutlet UIButton *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

//Hao-s addon////////////////////////////////////////////////
//(UIScrollView*) scrolling: Providing a scroll view to the DescViewController. I used it to have a little more space so I could arrange slap in a sizable table of comments.
@property (weak, nonatomic) IBOutlet UIScrollView *scrolling;

///(UITextField*) commentTextEntry: text box where users will be able to enter comments.
@property (weak, nonatomic) IBOutlet UITextField *commentTextEntry;

//Button to toggle visibility.
@property (weak, nonatomic) IBOutlet UIButton *visibilityButton;
@property (weak, nonatomic) IBOutlet UIButton *commentSettingButton;

@property (weak, nonatomic) IBOutlet UITableView *tableOfComments;

@property (weak, nonatomic) IBOutlet UILabel *commentsLabel;
@property (weak, nonatomic) IBOutlet UILabel *visibleLabel;
////////////////////////////////////////////////////////////////
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
