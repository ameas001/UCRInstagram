//
//  FollowingViewController.m
//  UCRInstagram
//
//  Created by Tony Albor on 3/8/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "FollowingViewController.h"
#import "Cell.h"

@interface FollowingViewController ()

@end

@implementation FollowingViewController

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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // method that needs to be implemented to return the number of rows in a section
    // this tableView only uses one section
    if(self.isFollowing) {
        NSLog(@"returning following: %d",self.followingArray.count);
        return [self.followingArray count];
    }
    else if(self.isFollower) {
        NSLog(@"return follower: %d", self.followerArray.count);
        return [self.followerArray count];
    } else {
        NSLog(@"return table rows: %d",5);
        return 5;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"GOT IN");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSLog(@"DELETING");
        if(self.isFollowing) {
            [self.followingArray removeObjectAtIndex:[indexPath row] - 1];
        } else if(self.isFollower) {
            [self.followerArray removeObjectAtIndex:[indexPath row] - 1];
        } else {
            NSLog(@"ERROR commitEditingStyle.");
        }
        
        
        // delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // this method sets the cell's properties
    UITableViewCell *cell;
    NSLog(@"Index Path: %@", indexPath);
    cell = [self.tableView dequeueReusableCellWithIdentifier:nil];
    Cells *_cell;
    if(self.isFollower) {
        _cell = [self.followerArray objectAtIndex:[indexPath row]];
    } else if(self.isFollowing) {
        _cell = [self.followingArray objectAtIndex:[indexPath row]];
    } else {
        NSLog(@"ERROR: cellForRowAtIndexPath.");
    }
    
    
    if(!cell) {
        cell = [[Cells alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:nil];
        /*
         if(self.isFollower) {
         [[cell textLabel] setText];
         } else if(self.isFollowing) {
         [[cell textLabel] setText:@""];
         } else {
         
         }
         */
        if(self.isFollower) {
            [[cell textLabel] setText:[_cell valueForKey:@"username"]];
        } else if(self.isFollowing) {
            [[cell textLabel] setText:[_cell valueForKey:@"following"]];
        } else {
            NSLog(@"ERROR: cellForRowAtIndexPath: if(!cell)");
        }
        
        
    }
    UISwipeGestureRecognizer *swipeAwayCellToTheLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedToTheLeft:)];
    UISwipeGestureRecognizer *swipeAwayCellToTheRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(cellSwipedToTheRight:)];
    [swipeAwayCellToTheLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeAwayCellToTheRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [cell addGestureRecognizer:swipeAwayCellToTheLeft];
    [cell addGestureRecognizer:swipeAwayCellToTheRight];
    UITapGestureRecognizer *tapCell = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
    
    [cell addGestureRecognizer:tapCell];
    cell.editing = YES;
    
    return cell;
}

- (void)cellSwipedToTheLeft:(UIGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        UITableViewCell *cell = (UITableViewCell *)gestureRecognizer.view;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        NSString *otherUserName = cell.textLabel.text;
        NSString *userName = [[PFUser currentUser] username];
        NSLog(@"USERNMAE: %@",otherUserName);
        [self.tableView beginUpdates];
        if(self.isFollower) {/*
                              [self.followerArray removeObjectAtIndex:indexPath.row];
                              PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Following"];
                              
                              [friendsQuery whereKey:@"following" equalTo:userName];
                              [friendsQuery whereKey:@"username" equalTo:otherUserName];
                              [friendsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                              if(!error) {
                              [object deleteInBackground];
                              } else {
                              
                              }
                              }];
                              */
        } else if(self.isFollowing) {
            [self.followingArray removeObjectAtIndex:indexPath.row];
            PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Following"];
            [friendsQuery whereKey:@"username" equalTo:userName];
            [friendsQuery whereKey:@"following" equalTo:otherUserName];
            [friendsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if(!error) {
                    [object deleteInBackground];
                } else {
                    
                }
            }];
            
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
            
        } else {
            NSLog(@"ERROR");
        }
        
        
    }
}

- (void)cellSwipedToTheRight:(UIGestureRecognizer *)gestureRecognizer {
    if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        UITableViewCell *cell = (UITableViewCell *)gestureRecognizer.view;
        NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
        NSString *otherUserName = cell.textLabel.text;
        NSString *userName = [[PFUser currentUser] username];
        [self.tableView beginUpdates];
        
        if(self.isFollower) {
            [self.followerArray removeObjectAtIndex:indexPath.row];
            
        } else if(self.isFollowing) {
            [self.followingArray removeObjectAtIndex:indexPath.row];
            
            PFQuery *friendsQuery = [PFQuery queryWithClassName:@"Following"];
            [friendsQuery whereKey:@"username" equalTo:userName];
            [friendsQuery whereKey:@"following" equalTo:otherUserName];
            [friendsQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                if(!error) {
                    [object deleteInBackground];
                } else {
                    
                }
            }];
            
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self.tableView endUpdates];
            
        } else {
            NSLog(@"ERROR");
        }
        //
    }
}


- (void)cellTapped:(UITapGestureRecognizer *) gestureRecognizer {
    UITableViewCell *cell = (UITableViewCell *)gestureRecognizer.view;
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    NSString *userNameClickedOn = cell.textLabel.text;
    PFQuery *usersQuery = [PFUser query];
    [usersQuery whereKey:@"username" equalTo:userNameClickedOn];
    
    
    
    
    NSLog(@"CELL: %@",cell);
    NSLog(@"INDEX PATH: %@",indexPath);
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ProfileViewController *lvc = [st instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    lvc.userClickedOn = userNameClickedOn;
    [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:lvc animated:YES completion:nil];
}

- (void)viewDidLoad
{
    NSLog(@"is following: %d",self.isFollowing);
    NSLog(@"is follower:  %d",self.isFollower);
    PFUser *currentUser = [PFUser currentUser];
    /*
     PFQuery *followersQuery = [PFQuery queryWithClassName:@"Following"];
     [followersQuery whereKey:@"following" equalTo:currentUser.username];
     
     PFQuery *followingQuery = [PFQuery queryWithClassName:@"Following"];
     [followingQuery whereKey:@"username" equalTo:currentUser.username];
     
     
     [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
     if(!error) {
     self.followingArray = [[NSMutableArray alloc] initWithArray:objects];
     for(int i = 0; i < self.followingArray.count; ++i) {
     NSLog(@"FOLLOWING: %@",[[self.followingArray objectAtIndex:i] objectForKey:@"following"]);
     }
     } else {
     NSLog(@"ERROR: viewDidLoad: followingQuery.");
     }
     }];
     
     [followersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
     if(!error) {
     self.followerArray = [[NSMutableArray alloc] initWithArray:objects];
     for(int i = 0; i < self.followerArray.count; ++i) {
     NSLog(@"FOLLOWER: %@",[[self.followerArray objectAtIndex:i] objectForKey:@"username"]);
     }
     } else {
     NSLog(@"ERROR: viewDidLoad: followersQuery.");
     }
     }];
     
     */
    [self.tableView setEditing:YES animated:YES];
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
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
