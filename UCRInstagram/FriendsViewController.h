//
//  FriendsViewController.h
//  UCRInstagram
//
//  Created by Tony Albor on 3/8/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowingViewController.h"


@interface FriendsViewController : UIViewController {
    NSMutableArray *followerArray;
    NSMutableArray *followingArray;
}
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *followingButton;
@property (weak, nonatomic) IBOutlet UIButton *followersButton;
@property (nonatomic) NSString *user;
@end
