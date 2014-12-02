//
//  FollowingViewController.h
//  UCRInstagram
//
//  Created by Tony Albor on 3/8/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ProfileViewController.h"

@interface FollowingViewController : UIViewController<UITableViewDataSource> {
    
}

@property (nonatomic) bool isFollowing;
@property (nonatomic) bool isFollower;
@property (nonatomic) NSMutableArray *followingArray;
@property (nonatomic) NSMutableArray *followerArray;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
