//
//  DescViewController.m
//  UCRInstagram
//
//  Created by Mandeep Singh on 1/30/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "DescViewController.h"

@interface DescViewController ()

@end

@implementation DescViewController

//Hao's Addon//////////////////////////////////////////////////////
#define FONT_SIZE 12.0f
#define CELL_MARGIN 2.0f
#define CELL_WIDTH 320.0f
//////////////////////////////////////////////////////////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)backButtonAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)favoriteButtonAction:(id)sender {
    PFUser *user = [PFUser currentUser];
    //PFRelation *relation = [user relationforKey:@"favoritesRelation"];
    //[relation addObject:imageobjkeep];
    //PFQuery *query = [PFQuery queryWithClassName:@"User"];
    //[query whereKey:@"]
    NSString * theID = imageobjkeep.objectId;
    NSMutableArray *objects = [user objectForKey:@"favorites"];
    //if(objects != nil) {
        
    
    if (objects == NULL){
        [user addObject:theID forKey:@"favorites"];
    }
    else if ([objects indexOfObject:theID] == NSNotFound)
    {
        [objects addObject:theID];
        //objects = [NSArray arrayWithArray:newObjects];
        [user setObject:objects forKey:@"favorites"];
        //[user addUniqueObject:theID forKey:@"favorites"];
    }
    else
    {
        [objects removeObject:theID];
        [user setObject:objects forKey:@"favorites"];
    }
    [user saveInBackground];
   // }
    //}
}

- (IBAction)deleteButtonAction:(id)sender {
    //Delete current image object in enhanced
    [imageobjkeep delete];
}

- (IBAction)clickOnName:(id)sender {
    NSString *userName = [[sender titleLabel] text];
    
    PFQuery *users = [PFUser query];
    [users whereKey:@"username" equalTo:userName];
    [users getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error) {
            PFUser *currentUser = object; // ignore the warning lol
            NSLog(@"Selected User: %@",currentUser.description);
        } else {
            NSLog(@"Error: clickOnName.");
        }
        
    }];

   // NSLog(@"Selected User: %@",currentUser);
    
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    ProfileViewController *lvc = [st instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    //lvc.isOwnProfile = NO;
    lvc.userClickedOn = userName;
    [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:lvc animated:YES completion:nil];
    
    
    NSLog(@"Finished clicking on username in enhanced view.\n");
}

//Hao's Addon///////////////////////////////////////////////////////////////////
- (IBAction)changeVisibility:(id)sender {
    if ([visibilityString isEqualToString:@"yes"]) {
        visibilityString = @"no";
        [_visibilityButton setTitle:@"Friends" forState:UIControlStateNormal];
    }
    else{
        visibilityString = @"yes";
        [_visibilityButton setTitle:@"Everyone" forState:UIControlStateNormal];
    }
    [imageobjkeep setObject:visibilityString forKey:@"everyone"];
    [imageobjkeep saveInBackground];
}

- (IBAction)changeComment:(id)sender {
    if ([commentSettingString isEqualToString:@"yes"]){
        commentSettingString = @"no";
        [_commentSettingButton setTitle:@"Everyone" forState:UIControlStateNormal];
    }
    else{
        commentSettingString = @"yes";
        [_commentSettingButton setTitle:@"Friends" forState:UIControlStateNormal];
    }
    [imageobjkeep setObject:commentSettingString forKey:@"friendsOnly"];
    [imageobjkeep saveInBackground];
}
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Hao's Addon/////////////////////////////////////////////////////////////////
    self.scrolling.contentSize=CGSizeMake(320,842);
    visibilityString = [imageobjkeep objectForKey:@"everyone"];
    commentSettingString = [imageobjkeep objectForKey:@"friendsOnly"];
    if([visibilityString isEqualToString:@"yes"])
        [_visibilityButton setTitle:@"Everyone" forState:UIControlStateNormal];
    else
        [_visibilityButton setTitle:@"Friends" forState:UIControlStateNormal];
    if([commentSettingString isEqualToString:@"yes"])
        [_commentSettingButton setTitle:@"Friends" forState:UIControlStateNormal];
    else
        [_commentSettingButton setTitle:@"Everyone" forState:UIControlStateNormal];
    ///////////////////////////////////////////////////////////////////
    
    //Current user
    PFUser *current = [PFUser currentUser];
    //Stop user from editing uitextview, keep scrolling
    [_descTextView setEditable:NO];
    _descTextView.scrollEnabled = YES;
    
    //Get info from where it comes from
    NSString *userkeep;
    NSString *datekeep;
    UIImage *imagekeep;
    NSString *desckeep;
    
    //Either camera, explore, or profile
    PictureViewController *descpass = [[PictureViewController alloc]init];
    if([descpass getComefrom]){
        userkeep = [descpass getName];
        imagekeep = [descpass getImage];
        desckeep = [descpass getDesc];
        datekeep = [descpass getDate];
        imageobjkeep = [descpass getImageObject];
        [descpass setCame];
    }
    
    ExploreViewController *descpass1 = [[ExploreViewController alloc]init];
    if([descpass1 getComefrom]){
        userkeep = [descpass1 getName];
        imagekeep = [descpass1 getImage];
        desckeep = [descpass1 getDesc];
        datekeep = [descpass1 getDate];
        imageobjkeep = [descpass1 getImageObject];
        [descpass1 setCame];
    }
    
    ProfileViewController *descpass2 = [[ProfileViewController alloc]init];
    if([descpass2 getComefrom]){
        userkeep = [descpass2 getName];
        imagekeep = [descpass2 getImage];
        desckeep = [descpass2 getDesc];
        datekeep = [descpass2 getDate];
        imageobjkeep = [descpass2 getImageObject];
        [descpass2 setCame];
        
        FavoritesViewController *descpass3 = [[FavoritesViewController alloc]init];
        if([descpass3 getComeFrom])
        {
            userkeep = [descpass3 getName];
            imagekeep = [descpass3 getImage];
            desckeep = [descpass3 getDesc];
            datekeep = [descpass3 getDate];
            imageobjkeep = [descpass3 getImageObject];
            [descpass3 setCame];
        }
    }
    
    //Set info from location
    [_userLabel setTitle:userkeep forState:UIControlStateNormal];
    //[_userLabel setText:userkeep];
    [_dateLabel setText:datekeep];
    _descTextView.text = desckeep;
    _previewImageView.image = imagekeep;
    
    //Hao's add-on//////////////////////////////////////////////////////////////
    //Grabbing NSMutableArray from Parse containing comments for the image.
    commentsArray = [imageobjkeep objectForKey:@"comments"];
    ///////////////////////////////////////////////////////////////////
    
    //Hide delete button if it's not your image
    NSString *name_user = current.username;
    if([name_user  isEqualToString:_userLabel.titleLabel.text]){
        [_deleteButton setHidden:NO];
        //Hao's Addon//////////////////////////////////////////////////////////////
        //Grabbing NSMutableArray from Parse containing comments for the image.
        [_visibilityButton setHidden:NO];
        [_commentSettingButton setHidden:NO];
        [self.commentsLabel setHidden:NO];
        [self.visibleLabel setHidden:NO];
        ///////////////////////////////////////////////////////////////////
    }
    else{
        [_deleteButton setHidden:YES];
        //Hao's Addon/////////////////////////////////////////////////////////////
        [_visibilityButton setHidden:YES];
        [_commentSettingButton setHidden:YES];
        [self.commentsLabel setHidden:YES];
        [self.visibleLabel setHidden:YES];
        ///////////////////////////////////////////////////////////////////
        NSLog(@"SHSHSHHS");
    }
    
    //Hao's Addon////////////////////////////////////////////////////////////////////
    //Checks to see if the current user can comment on the current image.
    //
    //This is done by: First, check to see if everyone can comment.
    //If not, then for the current image, query for anyone following the owner of the image. Then query to see if the current user is someone is following the owner of the image.
    NSString * onlyFriendsCanComment = [imageobjkeep objectForKey:@"friendsOnly"];
    NSLog(@"onlyFriendsCanComment: %@", onlyFriendsCanComment);
    if( [onlyFriendsCanComment isEqualToString:@"yes"] ){
        NSString *imageOwner = [imageobjkeep objectForKey:@"ownerUsername"];
        NSLog(@"imageOwner: %@", imageOwner);
        PFQuery * queryForFollowers = [PFQuery queryWithClassName:@"Following"];
        [queryForFollowers whereKey:@"following" equalTo:imageOwner];
        [queryForFollowers whereKey:@"username" equalTo:name_user];
        if([queryForFollowers countObjects] == 0)
            [self.commentTextEntry setEnabled:false];
        else
            [self.commentTextEntry setEnabled:true];
    }
    else
        [self.commentTextEntry setEnabled:true];
    /////////////////////////////////////////////////////////////////////////
    
}

//Hao's Addon///////////////////////////////////////////////////////////////////
//
//Function to process an event when the return button is clicked when inputting into the textfield.
//
//The function will grab the current username and the inputted text and save it into an NSMutableArray.
//This array is then uploaded to the Parse database, in the "images" object under "comments".
//The table will then reload and display the new comment.
//
//"comments" in the Parse database is a MutableArray of MutableArray.
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.commentTextEntry resignFirstResponder];
    
    PFUser *current = [PFUser currentUser];
    
    NSString * comment = self.commentTextEntry.text;
    NSString * trimmedComment = [comment stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString * userCommenting = current.username;
    
    //Check to see if there is an input. trimmedComment is comment with leading whitespace and trailing whitespace removed.
    if([trimmedComment length] > 0 ){
        NSMutableArray * commentEntry = [NSMutableArray arrayWithObjects:userCommenting, comment, nil];
        [imageobjkeep addObject:commentEntry forKey:@"comments"];
        [imageobjkeep saveInBackground];
        commentsArray = [imageobjkeep objectForKey:@"comments"];
        [self.tableOfComments reloadData];
    }
    
    self.commentTextEntry.text = @"";
    
    
    return YES;
}
///////////////////////////////////////////////////////////////////

//Hao's Addon///////////////////////////////////////////////////////////////////
//
//Calculate the height needed for a cell entry in the TableView.
//Height of a cell is taken by calculating:
//the height of the username + the height of the comment + CELL_MARGIN*2.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *comment = [[commentsArray objectAtIndex:[indexPath row]] objectAtIndex:1];
    /*
     NSLog(@"indexPath: %@", indexPath);
     NSLog(@"indexPath row: %i", [indexPath row]);
     NSLog(@"comment for item: %@", comment);
     */
    NSString *usr = [[commentsArray objectAtIndex:[indexPath row]] objectAtIndex:0];
    
    CGSize constraint = CGSizeMake(CELL_WIDTH - (CELL_MARGIN * 2), 20000.0f);
    
    CGSize size = [comment sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize userSize = [usr sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint
                          lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX((size.height+userSize.height), 44.0f);
    
    return height + (CELL_MARGIN * 2);
}
///////////////////////////////////////////////////////////////////


//Hao's Addon//////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [commentsArray count];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
////////////////////////////////////////////////////////////////////////

//Hao's Addon///////////////////////////////////////////////////////////////////
//The TableView is populated with TableViewCells programmatically. There's no TableViewCell in the storyboard.
//This way, the height of each cell is dynamic. The height will change based on the size of the comment.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * reuser = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
    UILabel * comment = nil;
    UILabel * usr = nil;
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        
        //Attributes of the comment text
        comment = [[UILabel alloc] initWithFrame:CGRectZero];
        [comment setLineBreakMode:UILineBreakModeWordWrap];
        [comment setMinimumFontSize:FONT_SIZE];
        [comment setNumberOfLines:0];
        [comment setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        [comment setBackgroundColor:self.view.backgroundColor];
        [comment setTag:1];
        
        //Attributes of the username text
        usr = [[UILabel alloc] initWithFrame:CGRectZero];
        [usr setLineBreakMode:UILineBreakModeWordWrap];
        [usr setMinimumFontSize:FONT_SIZE];
        [usr setNumberOfLines:0];
        [usr setFont:[UIFont systemFontOfSize:FONT_SIZE]];
        
        //For the UIColor in textColor, I used http://uicolor.org . It's a color panel that gives you the code for the respected UIColor
        usr.textColor = [UIColor colorWithRed:34/255.0f green:161/255.0f blue:240/255.0f alpha:1.0f];
        [usr setBackgroundColor:self.view.backgroundColor];
        [usr setTag:1];
        
        [[cell contentView] addSubview:comment];
        [[cell contentView] addSubview:usr];
    }
    
    //Accessing commentsArray to grab user + comments.
    NSString *text = [[commentsArray objectAtIndex:[indexPath row]] objectAtIndex:1];
    NSString *usrText = [[commentsArray objectAtIndex:[indexPath row]] objectAtIndex:0];
    CGSize constraint = CGSizeMake(CELL_WIDTH - (CELL_MARGIN * 2), 20000.0f);
    
    
    //Getting the size of the username block (size_usr) and the comment block (size)
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    CGSize size_usr = [usrText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    //Set the attributes then create the block for where the comment will reside.
    [comment setText:text];
    [comment setFrame:CGRectMake(CELL_MARGIN, CELL_MARGIN+size_usr.height, CELL_WIDTH - (CELL_MARGIN * 2), size.height)];
    
    //Set the attributes then create the block for where the username will reside.
    [usr setText:usrText];
    [usr setFrame:CGRectMake(CELL_MARGIN, CELL_MARGIN, CELL_WIDTH - (CELL_MARGIN * 2), size_usr.height)];
    return cell;
}
///////////////////////////////////////////////////////////////////

- (void)keyboardWillHide:(NSNotification *)notif {
    [self setViewMoveUp:NO];
}


- (void)keyboardWillShow:(NSNotification *)notif{
    [self setViewMoveUp:YES];
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
    stayup = YES;
    [self setViewMoveUp:YES];
}


- (void)textFieldDidEndEditing:(UITextField *)textField {
    stayup = NO;
    [self setViewMoveUp:NO];
}
#define kOFFSET_FOR_KEYBOARD 216.0
//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMoveUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    NSLog(@"unload");
    [self setDescTextView:nil];
    [self setPreviewImageView:nil];
    [self setUserLabel:nil];
    [self setDateLabel:nil];
    [self setBackButton:nil];
    NSLog(@"out of desc view");
    [self setDeleteButton:nil];
    [self setUserLabel:nil];
    
    //Hao's Addon///////////////////////
    [self setScrolling:nil];
    [self setCommentTextEntry:nil];
    [self setTableOfComments:nil];
    [self setVisibilityButton:nil];
    [self setCommentSettingButton:nil];
    [self setVisibleLabel:nil];
    [self setCommentsLabel:nil];
    //////////////////////////////////////////
    

    [super viewDidUnload];
}
@end
