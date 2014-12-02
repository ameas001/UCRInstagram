//
//  ProfileViewController.m
//  UCRInstagram
//
//  Created by user2349 on 1/31/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


-(NSString *)getName
{
    return user_text;
}
-(NSString *)getDate
{
    return pass_date;
}
-(UIImage *)getImage
{
    return pass_image;
}
-(NSString *)getDesc
{
    return pass_desc;
}
-(PFObject*)getImageObject
{
    return pass_imageobject;
}
-(bool)getComefrom
{
    return camefrom;
}
-(void)setCame
{
    camefrom = NO;
}

-(void)sendInfo:(int)i
{
    user_text = [userNameArray objectAtIndex:i];
    camefrom = YES;
    pass_image = [imageArray objectAtIndex:i];
    pass_desc = [descriptionArray objectAtIndex:i];
    pass_imageobject = [imageobjects objectAtIndex:i];
    
    NSDate *currentDate = [dateArray objectAtIndex:i];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    pass_date = dateString;
    
    //Switch over to the enhanced view page
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"DescViewController"];
    [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:lvc animated:YES completion:nil];
}
- (IBAction)button1:(id)sender {
    if([previewImageArray count] > (0+page*6)){
    [self sendInfo:(page*6+0)];
    }
}
- (IBAction)button2:(id)sender {
    if([previewImageArray count] > (1+page*6)){
    [self sendInfo:(page*6+1)];
    }
}
- (IBAction)button3:(id)sender {
    if([previewImageArray count] > (2+page*6)){
    [self sendInfo:(page*6+2)];
    }
}
- (IBAction)button4:(id)sender {
    if([previewImageArray count] > (3+page*6)){
    [self sendInfo:(page*6+3)];
    }
}
- (IBAction)button5:(id)sender {
    if([previewImageArray count] > (4+page*6)){
    [self sendInfo:(page*6+4)];
    }
}
- (IBAction)button6:(id)sender {
    if([previewImageArray count] > (5+page*6)){
    [self sendInfo:(page*6+5)];
    }
}

-(void)loadButtons
{
    //Load all with no image
    [_buttonImage1 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage2 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage3 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage4 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage5 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage6 setBackgroundImage:nil forState:UIControlStateNormal];
    
    //Load buttons with images
    if([previewImageArray count] > (0+page*6)){
        
        [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:(0+page*6)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (1+page*6)){
        [_buttonImage2 setBackgroundImage:[previewImageArray objectAtIndex:(1+page*6)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (2+page*6)){
        [_buttonImage3 setBackgroundImage:[previewImageArray objectAtIndex:(2+page*6)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (3+page*6)){
        [_buttonImage4 setBackgroundImage:[previewImageArray objectAtIndex:(3+page*6)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (4+page*6)){
        [_buttonImage5 setBackgroundImage:[previewImageArray objectAtIndex:(4+page*6)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (5+page*6)){
        [_buttonImage6 setBackgroundImage:[previewImageArray objectAtIndex:(5+page*6)] forState:UIControlStateNormal];
    }
}
- (IBAction)prevAction:(id)sender {
    page = page-1;
    if(page < 0){page = 0;}
    [self loadButtons];
    NSLog(@"Page: %d and PC: %d", page, pageCounter);
}
- (IBAction)nextAction:(id)sender {
    page = page+1;
    if(page*6 >= [previewImageArray count]){page = page-1;}
    //pageCounter++;
    //[self downloadImages:c_user];
    [self loadButtons];
    NSLog(@"NEXT! Page: %d and PC: %d", page, pageCounter);
}



-(IBAction)logoutButtonAction:(id)sender{
    [PFUser logOut];
    PFUser *currentUser = [PFUser currentUser];
}

- (IBAction)editProfileAction:(id)sender {
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    EditProfileViewController *edit = [st instantiateViewControllerWithIdentifier:@"EditProfileViewController"];
    
    NSString *userName = _userLabel.text;
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"username" equalTo:userName];
    [userQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            
            PFUser *currentUser = [objects objectAtIndex:0];
            edit.currentUser = currentUser;
            
        } else {
            
        }
        
    }];
    
    
    [edit setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:edit animated:YES completion:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // method that needs to be implemented to return the number of rows in a section
    // this tableView only uses one section
    return 5;
}

- (void)tableView: (UITableView*)tableView willDisplayCell: (UITableViewCell*)cell
forRowAtIndexPath: (NSIndexPath*)indexPath {// method gets called each time a cell is loaded
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //self.isOwnProfile = YES;
        self.currentUser = [PFUser currentUser];
    }
    return self;
}




-(void)downloadImages:(PFUser *)currentUser {
    NSLog(@"DLOAD_IMAGES");
    //PFUser *currentUser = [PFUser currentUser];
    
    PFQuery *query = [PFQuery queryWithClassName:@"images"];
    [query whereKey:@"ownerUsername" equalTo:currentUser.username];
    
    //Limit query size
    //query.limit = 15;
    //query.skip = 15*pageCounter;
    
    //date, image, username, preview, description
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            // successfully downloaded images
            for(int i = 0; i < objects.count; ++i) {
                //create image object
                PFObject *imageObject = [objects objectAtIndex:i];
                PFFile *imageFile = [imageObject objectForKey:@"pic"];
                NSData *imageData = [imageFile getData];
                
                PFFile* previewImageFile = [imageObject objectForKey:@"preview"];
                NSData *previewImageData = [previewImageFile getData];
                
                //store image information in arrays
                [imageArray addObject:[UIImage imageWithData:imageData]];
                [descriptionArray addObject:[imageObject objectForKey:@"desc"]];
                [dateArray addObject:[imageObject createdAt]];
                [previewImageArray addObject:[UIImage imageWithData:previewImageData]];
                [userNameArray addObject:[imageObject objectForKey:@"ownerUsername"]];
                [imageobjects addObject:[objects objectAtIndex:i]];
            }
            
            NSLog(@"IMAGEARRAYCOUNT: %d", [previewImageArray count]);
            [self loadButtons];            
        } else {
            // error downloading images
            NSLog(@"Error downloading user's images.\n");
        }
    }];
    
    
    /*[_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:3] forState:UIControlStateNormal];
     [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:4] forState:UIControlStateNormal];
     [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:5] forState:UIControlStateNormal];
     */
}

- (void)loadOwnProfile {
    NSLog(@"LOAD_OWN_PROF");
    //Loading the profile page info
    _logoutButton.hidden = NO;
    _followingButton.hidden = YES;
    _editProfileButton.hidden = NO;
    _backButton.hidden = YES;
    
    PFUser *currentUser = [PFUser currentUser];
    [currentUser refreshInBackgroundWithBlock:nil];
    
    [_userLabel setText:[currentUser objectForKey:@"username"]];
    PFFile *userpf = [currentUser objectForKey:@"profilePic"];
    NSURL *userpurl = [NSURL URLWithString:userpf.url];
    NSData *userpd = [NSData dataWithContentsOfURL:userpurl];
    
    _profilepicUI.image = [UIImage imageWithData:userpd];
    _nameLabel.text = [currentUser objectForKey:@"name"];
    //_birthdayLabel.text = [currentUser objectForKey:@"Birthday"];
    //_genderLabel.text = [currentUser objectForKey:@"gender"]; // still haven't implemented in parse
    
    NSDate *birthday = [currentUser objectForKey:@"Birthday"];
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc] init];
    [formattedDate setDateStyle:NSDateFormatterShortStyle];
    [formattedDate setTimeStyle:NSDateFormatterNoStyle];
    _birthdayLabel.text = [formattedDate stringFromDate:birthday];
    _genderLabel.text = [currentUser objectForKey:@"gender"];
    
    [_aboutMeDescUITV setEditable:NO];
    _aboutMeDescUITV.scrollEnabled = YES;
    _aboutMeDescUITV.text = [currentUser objectForKey:@"aboutMe"];
    _tableView.tableHeaderView = _tableHeaderView;
    
    c_user = currentUser;
    [self downloadImages:currentUser];
}

-(BOOL)isFollowing:(PFUser *)otherUser {
    PFUser *currentUser = [PFUser currentUser];
    PFQuery *followingQuery = [PFQuery queryWithClassName:@"Following"];
    [followingQuery whereKey:@"username" equalTo:currentUser.username];
    [followingQuery whereKey:@"following" equalTo:otherUser.username];
    
    __block bool value;
    
    [followingQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            if(objects.count > 0) {
                value = YES;
                NSLog(@"YES");
            } else {
                value = NO;
                NSLog(@"NO");
            }
        } else {
            NSLog(@"ERROR: isFollowing");
        }
        
    }];
    
    
    return value;
}

- (void)loadUserProfile:(PFUser *)currentUser {
    _followingButton.hidden = NO;
    _backButton.hidden = NO;
    _editProfileButton.hidden = YES;
    _logoutButton.hidden = YES;
    
    if([self isFollowing:currentUser]) {
        _followingButton.titleLabel.text = @"Following";
        NSLog(@"ITS FOLLOWING");
    } else {
        _followingButton.titleLabel.text = @"Follow";
        NSLog(@"NOT FOLLOWING");
    }
    
    NSLog(@"User: %@\n",currentUser.username);
    
    [currentUser refreshInBackgroundWithBlock:nil];
    
    [_userLabel setText:[currentUser objectForKey:@"username"]];
    PFFile *userpf = [currentUser objectForKey:@"profilePic"];
    NSURL *userpurl = [NSURL URLWithString:userpf.url];
    NSData *userpd = [NSData dataWithContentsOfURL:userpurl];
    
    PFQuery *imageQuery = [PFQuery queryWithClassName:@"images"];
    [imageQuery whereKey:@"ownerUsername" equalTo:currentUser.username];
    NSLog(@"SLDKJFLDSFJDLFDF");
    [imageQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error) {
            
            /*
             //successfully downloaded images
             PFObject *objectImage = [objects objectAtIndex:objects.count-1];
             PFFile *pictureFile = [objectImage objectForKey:@"pic"];
             NSData *pictureData = [pictureFile getData];
             // _imageTest.image = [UIImage imageWithData:pictureData];
             NSLog(@"Objects count: %d",objects.count);
             NSLog(@"Type of object: %@",[[objects objectAtIndex:objects.count-1] description]);
             
             */
        } else {
            // error
            NSLog(@"Error \"findObjectsInBackgroundWithBlock:\" ");
        }
    }];
    
    _profilepicUI.image = [UIImage imageWithData:userpd];
    _nameLabel.text = [currentUser objectForKey:@"name"];
    //_birthdayLabel.text = [currentUser objectForKey:@"Birthday"];
    //_genderLabel.text = [currentUser objectForKey:@"gender"]; // still haven't implemented in parse
    
    NSDate *birthday = [currentUser objectForKey:@"Birthday"];
    NSDateFormatter *formattedDate = [[NSDateFormatter alloc] init];
    [formattedDate setDateStyle:NSDateFormatterShortStyle];
    [formattedDate setTimeStyle:NSDateFormatterNoStyle];
    _birthdayLabel.text = [formattedDate stringFromDate:birthday];
    _genderLabel.text = [currentUser objectForKey:@"gender"];
    
    [_aboutMeDescUITV setEditable:NO];
    _aboutMeDescUITV.scrollEnabled = YES;
    _aboutMeDescUITV.text = [currentUser objectForKey:@"aboutMe"];
    _tableView.tableHeaderView = _tableHeaderView;
    
    c_user = currentUser;
    [self downloadImages:currentUser];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [imageArray removeAllObjects];
    [dateArray removeAllObjects];
    [previewImageArray removeAllObjects];
    [descriptionArray removeAllObjects];
    [userNameArray removeAllObjects];
    [imageobjects removeAllObjects];
    
    
    if(_userClickedOn == nil) {
        [self loadOwnProfile];
        NSLog(@"WOWOWOWOW");
    } else {
        PFQuery *usersQuery = [PFUser query];
        
        [usersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error) {
                NSLog(@"NO ERROR");
                for(int i = 0; i < objects.count; ++i) {
                    if([self.userClickedOn isEqualToString:[[objects objectAtIndex:i] objectForKey:@"username"]]) {
                        // load user's profile
                        NSLog(@"COOOOOL");
                        PFUser *user = [objects objectAtIndex:i];
                        [self loadUserProfile:user];
                    }
                }
                
            } else {
                NSLog(@"ERRORRR");
                
            }
            if([_userLabel.text isEqualToString:@"Username"])
            {
                [self loadOwnProfile];
            }
            
        }];
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"VIEW_DID_LOAD");
	page = 0;
    pageCounter = 0;
    imageArray = [[NSMutableArray alloc] init];
    dateArray = [[NSMutableArray alloc] init];
    previewImageArray = [[NSMutableArray alloc] init];
    descriptionArray = [[NSMutableArray alloc] init];
    userNameArray = [[NSMutableArray alloc] init];
    imageobjects = [[NSMutableArray alloc] init];
    
   
    
    /*if(_userClickedOn == nil) {
        [self loadOwnProfile];
        NSLog(@"WOWOWOWOW");
    } else {
        PFQuery *usersQuery = [PFUser query];
        
        [usersQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error) {
                NSLog(@"NO ERROR");
                for(int i = 0; i < objects.count; ++i) {
                    if([self.userClickedOn isEqualToString:[[objects objectAtIndex:i] objectForKey:@"username"]]) {
                        // load user's profile
                        NSLog(@"COOOOOL");
                        PFUser *user = [objects objectAtIndex:i];
                        [self loadUserProfile:user];
                    }
                }
                
            } else {
                NSLog(@"ERRORRR");
                
            }
            if([_userLabel.text isEqualToString:@"Username"])
            {
                [self loadOwnProfile];
            }
            
        }];
    }*/
}

- (IBAction)followAction:(id)sender {
    PFUser *currentUser = [PFUser currentUser];
    
    PFQuery *usersQuery = [PFUser query];
    [usersQuery whereKey:@"username" equalTo:self.userLabel.text];
    
    /*
     UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
     ProfileViewController *profile = [st instantiateViewControllerWithIdentifier:@"ProfileViewController"];
     */
    
    
    
    PFObject *following = [PFObject objectWithClassName:@"Following"];
    [following setObject:currentUser.username forKey:@"username"];
    [following setObject:self.userLabel.text forKey:@"following"];
    [following saveInBackground];
    self.followingButton.titleLabel.text = @"Following";
}


- (IBAction)backButtonAction:(id)sender {
    /*
     UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
     UIViewController *profile = [st instantiateViewControllerWithIdentifier:@"ProfileViewController"];
     [profile setModalPresentationStyle:UIModalPresentationFullScreen];
     [profile dismissModalViewControllerAnimated:YES];
     */
    self.userClickedOn = nil;
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)friendsAction:(id)sender {
    
    NSString *user = self.userClickedOn;
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    FriendsViewController *friends = [st instantiateViewControllerWithIdentifier:@"FriendsViewController"];
    friends.user = user;
    [friends setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentModalViewController:friends animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidDisappear:(BOOL)animated{
    //When the view disappears we need to remove it from memory
    NSLog(@"Disappear");
 
    
    [self viewDidUnload];
}

-(void)viewDidUnload{
    [self setLogoutButton:nil];
    [self setProfilepicUI:nil];
    [self setUserLabel:nil];
    [self setNameLabel:nil];
    [self setEditProfileButton:nil];
    [self setTableHeaderView:nil];
    [self setTableView:nil];
    [self setBirthdayLabel:nil];
    [self setGenderLabel:nil];
    [self setUserLabel:nil];
    [self setLogoutButton:nil];
    [self setProfilepicUI:nil];
    [self setNameLabel:nil];
    [self setBirthdayLabel:nil];
    [self setGenderLabel:nil];
    [self setEditProfileButton:nil];
    [self setTableHeaderView:nil];
    [self setTableView:nil];
    //[self setButtonImage1:nil];
    //[self setButtonImage2:nil];
    //[self setButtonImage3:nil];
    //[self setButtonImage4:nil];
    //[self setButtonImage5:nil];
    //[self setButtonImage6:nil];
    [self setPreviousButton:nil];
    [self setNextButton:nil];
    [self setAboutMeDescUITV:nil];
    [self setBackButton:nil];
    [self setFollowingButton:nil];
    [super viewDidUnload];
}


@end
