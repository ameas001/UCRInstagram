//
//  FriendsPicsViewController.m
//  UCRInstagram
//
//  Created by user2140 on 3/6/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "FriendsPicsViewController.h"

@interface FriendsPicsViewController ()

@end

@implementation FriendsPicsViewController

-(void)downloadImages
{
    PFUser *currentUser = [PFUser currentUser];
    
    //Get friends first
    PFQuery *qFriends = [PFQuery queryWithClassName:@"Following"];
    [qFriends whereKey:@"username" equalTo:currentUser.username];
    [qFriends findObjectsInBackgroundWithBlock:^(NSArray *objFriends, NSError *error) {
        if(!error){
            NSMutableArray *friendsList = [[NSMutableArray alloc]init];
            for(int i=0; i<objFriends.count; i++)
            {
                [friendsList addObject:[[objFriends objectAtIndex:i] objectForKey:@"following"]];
            }
            PFQuery *query = [PFQuery queryWithClassName:@"images"];
            [query whereKey:@"ownerUsername" containedIn:friendsList];
    
            //Limiting query search for images and skipping
            query.limit = 20;
            query.skip = 20*pageCounter;
           
            //date, image, username, preview, description
            [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if(!error) {
                    NSLog(@"THIS IS DUMB: %d", [objects count]);
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
                        [imageobjects addObject:imageObject];
                        [global_images1 addObject:imageObject];
                        NSLog(@"STOP");
                        //Load button images
                        [self loadButtons];
                        
                    }
                }
                else {
                    // error downloading images
                    NSLog(@"Error downloading user's images.\n");
                }
            }];
        }
     }];

}


-(void)loadButtons
{
    //Load all with no image
    [_Butt1 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt2 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt3 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt4 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt5 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt6 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt7 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt8 setBackgroundImage:nil forState:UIControlStateNormal];
    [_Butt9 setBackgroundImage:nil forState:UIControlStateNormal];
    
    
    //Load buttons with images
    if([previewImageArray count] > (0+page*9)){
        [_Butt1 setBackgroundImage:[previewImageArray objectAtIndex:(0+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (1+page*9)){
        [_Butt2 setBackgroundImage:[previewImageArray objectAtIndex:(1+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (2+page*9)){
        [_Butt3 setBackgroundImage:[previewImageArray objectAtIndex:(2+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (3+page*9)){
        [_Butt4 setBackgroundImage:[previewImageArray objectAtIndex:(3+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (4+page*9)){
        [_Butt5 setBackgroundImage:[previewImageArray objectAtIndex:(4+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (5+page*9)){
        [_Butt6 setBackgroundImage:[previewImageArray objectAtIndex:(5+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (6+page*9)){
        [_Butt7 setBackgroundImage:[previewImageArray objectAtIndex:(6+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (7+page*9)){
        [_Butt8 setBackgroundImage:[previewImageArray objectAtIndex:(7+page*9)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (8+page*9)){
        [_Butt9 setBackgroundImage:[previewImageArray objectAtIndex:(8+page*9)] forState:UIControlStateNormal];
    }
    
    
}
- (IBAction)prevAction:(id)sender {
    page = page-1;
    if(page < 0){page = 0;}
    [self loadButtons];
}
- (IBAction)nextAction:(id)sender {
    page = page+1;
    if(page*9 >= [previewImageArray count]){page = page-1;}
    pageCounter++;
    [self downloadImages];
    [self loadButtons];
}




-(void)sendInfo:(int)i
{
    user_text = [[global_images1 objectAtIndex:i] objectForKey:@"ownerUsername"];
    camefrom = YES;
    PFFile *file_get = [[global_images1 objectAtIndex:i] objectForKey:@"pic"];
    NSData *data_get = [file_get getData];
    pass_image = [UIImage imageWithData:data_get];
    pass_desc = [[global_images1 objectAtIndex:i] objectForKey:@"desc"];
    pass_imageobject = [global_images1 objectAtIndex:i];
    
    PFObject *obj = [global_images1 objectAtIndex:i];
    NSDate *currentDate = obj.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    pass_date = dateString;
    
    NSLog(@"DKDKDKD");
    //Switch over to the enhanced view page
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"DescViewController"];
    [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:lvc animated:YES completion:nil];
}

- (IBAction)Refresh:(id)sender {
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"TabViewController"];
    [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:lvc animated:NO completion:nil];
}

- (IBAction)Butt1Action:(id)sender {\
    if([previewImageArray count] > (0+page*9)){
    [self sendInfo:(page*9)+0];
    }
}
- (IBAction)Butt2Action:(id)sender {
    if([previewImageArray count] > (1+page*9)){
    [self sendInfo:(page*9)+1];
    }
}
- (IBAction)Butt3Action:(id)sender {
    if([previewImageArray count] > (2+page*9)){
    [self sendInfo:(page*9)+2];
    }
}
- (IBAction)Butt4Action:(id)sender {
    if([previewImageArray count] > (3+page*9)){
    [self sendInfo:(page*9)+3];
    }
}
- (IBAction)Butt5Action:(id)sender {
    if([previewImageArray count] > (4+page*9)){
    [self sendInfo:(page*9)+4];
    }
}
- (IBAction)Butt6Action:(id)sender {
    if([previewImageArray count] > (5+page*9)){
    [self sendInfo:(page*9)+5];
    }
}
- (IBAction)Butt7Action:(id)sender {
    if([previewImageArray count] > (6+page*9)){
    [self sendInfo:(page*9)+6];
    }
}
- (IBAction)Butt8Action:(id)sender {
    if([previewImageArray count] > (7+page*9)){
    [self sendInfo:(page*9)+7];
    }
}
- (IBAction)Butt9Action:(id)sender {
    if([previewImageArray count] > (8+page*9)){
    [self sendInfo:(page*9)+8];
    }
}

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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    firstLoad = YES;
    page = 0;
    pageCounter = 0;
    imageArray = [[NSMutableArray alloc] init];
    dateArray = [[NSMutableArray alloc] init];
    previewImageArray = [[NSMutableArray alloc] init];
    descriptionArray = [[NSMutableArray alloc] init];
    userNameArray = [[NSMutableArray alloc] init];
    imageobjects = [[NSMutableArray alloc] init];
    global_images1 = [[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated
{
    pageCounter = 0;
    page = 0;
    [imageArray removeAllObjects];
    [dateArray removeAllObjects];
    [previewImageArray removeAllObjects];
    [descriptionArray removeAllObjects];
    [userNameArray removeAllObjects];
    [imageobjects removeAllObjects];
    [global_images1 removeAllObjects];
    [self downloadImages];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setRefresh:nil];
    [self setButt1:nil];
    [self setButt2:nil];
    [self setButt3:nil];
    [self setButt4:nil];
    [self setButt5:nil];
    [self setButt6:nil];
    [self setButt7:nil];
    [self setButt8:nil];
    [self setButt9:nil];
    [self setPrevButton:nil];
    [self setNextButton:nil];
    [super viewDidUnload];
}
@end
