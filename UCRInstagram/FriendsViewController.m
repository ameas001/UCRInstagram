//
//  FriendsViewController.m
//  UCRInstagram
//
//  Created by Tony Albor on 3/8/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}
- (IBAction)backAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)followingAction:(id)sender {
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FollowingViewController *friends = [st instantiateViewControllerWithIdentifier:@"FollowingViewController"];
    friends.isFollowing = YES;
    friends.isFollower = NO;
    friends.followingArray = [[NSMutableArray alloc] initWithArray:self->followingArray];
    [friends setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentModalViewController:friends animated:YES];
    
}
- (IBAction)followersAction:(id)sender {
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FollowingViewController *friends = [st instantiateViewControllerWithIdentifier:@"FollowingViewController"];
    friends.isFollower = YES;
    friends.isFollowing = NO;
    friends.followerArray = [[NSMutableArray alloc] initWithArray:self->followerArray];
    [friends setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentModalViewController:friends animated:YES];
}

- (void)loadArrays {
    PFUser *currentUser = [PFUser currentUser];
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UITabBarController *tab = [st instantiateViewControllerWithIdentifier:@"TabViewController"];
    ProfileViewController *profile = [st instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    PFQuery *followingQuery;
    PFQuery *followersQuery;
    //if(profile.userClickedOn == nil) {
    NSLog(@"CHECKPOINT 1");
    followersQuery = [PFQuery queryWithClassName:@"Following"];
    NSLog(@"CHECKPOINT 2");
    [followersQuery whereKey:@"following" equalTo:currentUser.username];
    NSLog(@"CHECKPOINT 3");
    followingQuery = [PFQuery queryWithClassName:@"Following"];
    NSLog(@"CHECKPOINT 4");
    [followingQuery whereKey:@"username" equalTo:currentUser.username];
    NSLog(@"CHECKPOINT 5");
    /*} else {
     NSLog(@"bad condition");
     followersQuery = [PFQuery queryWithClassName:@"Following"];
     [followersQuery whereKey:@"following" equalTo:self.user];
     
     followingQuery = [PFQuery queryWithClassName:@"Following"];
     [followingQuery whereKey:@"username" equalTo:self.user];
     }*/
    
    
    [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            self->followingArray = [[NSMutableArray alloc] initWithArray:objects];
            for(int i = 0; i < self->followingArray.count; ++i) {
                NSLog(@"FOLLOWING: %@",[[self->followingArray objectAtIndex:i] objectForKey:@"following"]);
            }
        } else {
            NSLog(@"ERROR: viewDidLoad: followingQuery.");
        }
    }];
    
    [followersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            self->followerArray = [[NSMutableArray alloc] initWithArray:objects];
            for(int i = 0; i < self->followerArray.count; ++i) {
                NSLog(@"FOLLOWER: %@",[[self->followerArray objectAtIndex:i] objectForKey:@"username"]);
            }
        } else {
            NSLog(@"ERROR: viewDidLoad: followersQuery.");
        }
    }];
    
    
}

- (void)viewDidLoad
{
    [self loadArrays];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBackButton:nil];
    [self setFollowingButton:nil];
    [self setFollowersButton:nil];
    [super viewDidUnload];
}
@end
