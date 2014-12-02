//
//  FavoritesViewController - Favorites.m
//  UCRInstagram
//
//  Created by Luis Roman on 3/6/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

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
-(bool)getComeFrom
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
    UINavigationController *lvc = [st instantiateViewControllerWithIdentifier:@"DescViewController"];
    [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:lvc animated:YES completion:nil];
}

- (IBAction)button1:(id)sender {
    [self sendInfo:(page*12+0)];
}
- (IBAction)button2:(id)sender {
    [self sendInfo:(page*12+1)];
}
- (IBAction)button3:(id)sender {
    [self sendInfo:(page*12+2)];
}
- (IBAction)button4:(id)sender {
    [self sendInfo:(page*12+3)];
}
- (IBAction)button5:(id)sender {
    [self sendInfo:(page*12+4)];
}
- (IBAction)button6:(id)sender {
    [self sendInfo:(page*12+5)];
}
- (IBAction)button7:(id)sender {
    [self sendInfo:(page*12+6)];
}
- (IBAction)button8:(id)sender {
    [self sendInfo:(page*12+7)];
}
- (IBAction)button9:(id)sender {
    [self sendInfo:(page*12+8)];
}
- (IBAction)button10:(id)sender {
    [self sendInfo:(page*12+9)];
}
- (IBAction)button11:(id)sender {
    [self sendInfo:(page*12+10)];
}
- (IBAction)button12:(id)sender {
    [self sendInfo:(page*12+11)];
}
- (IBAction)previousPressed:(id)sender {
    
    page = page-1;
    if(page < 0){page = 0;}
    
    //Load all with no image
    [_buttonImage1 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage2 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage3 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage4 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage5 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage6 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage7 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage8 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage9 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage10 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage11 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage12 setBackgroundImage:nil forState:UIControlStateNormal];
    
    //Load buttons with images
    if([previewImageArray count] > (0+page*12))
    {
        [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:(0+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (1+page*12))
    {
        [_buttonImage2 setBackgroundImage:[previewImageArray objectAtIndex:(1+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (2+page*12))
    {
        [_buttonImage3 setBackgroundImage:[previewImageArray objectAtIndex:(2+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (3+page*12))
    {
        [_buttonImage4 setBackgroundImage:[previewImageArray objectAtIndex:(3+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (4+page*12))
    {
        [_buttonImage5 setBackgroundImage:[previewImageArray objectAtIndex:(4+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (5+page*12))
    {
        [_buttonImage6 setBackgroundImage:[previewImageArray objectAtIndex:(5+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (6+page*12))
    {
        [_buttonImage7 setBackgroundImage:[previewImageArray objectAtIndex:(6+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (7+page*12))
    {
        [_buttonImage8 setBackgroundImage:[previewImageArray objectAtIndex:(7+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (8+page*12))
    {
        [_buttonImage9 setBackgroundImage:[previewImageArray objectAtIndex:(8+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (9+page*12))
    {
        [_buttonImage10 setBackgroundImage:[previewImageArray objectAtIndex:(9+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (10+page*12))
    {
        [_buttonImage11 setBackgroundImage:[previewImageArray objectAtIndex:(10+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (11+page*12))
    {
        [_buttonImage12 setBackgroundImage:[previewImageArray objectAtIndex:(11+page*12)] forState:UIControlStateNormal];
    }
}
- (IBAction)nextPressed:(id)sender {
    page = page+1;
    if(page*12 >= [previewImageArray count]){page = page-1;}
    
    //Load all with no image
    [_buttonImage1 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage2 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage3 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage4 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage5 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage6 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage7 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage8 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage9 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage10 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage11 setBackgroundImage:nil forState:UIControlStateNormal];
    [_buttonImage12 setBackgroundImage:nil forState:UIControlStateNormal];
    
    //Load buttons with images
    if([previewImageArray count] > (0+page*12))
    {
        [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:(0+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (1+page*12))
    {
        [_buttonImage2 setBackgroundImage:[previewImageArray objectAtIndex:(1+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (2+page*12))
    {
        [_buttonImage3 setBackgroundImage:[previewImageArray objectAtIndex:(2+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (3+page*12))
    {
        [_buttonImage4 setBackgroundImage:[previewImageArray objectAtIndex:(3+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (4+page*12))
    {
        [_buttonImage5 setBackgroundImage:[previewImageArray objectAtIndex:(4+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (5+page*12))
    {
        [_buttonImage6 setBackgroundImage:[previewImageArray objectAtIndex:(5+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (6+page*12))
    {
        [_buttonImage7 setBackgroundImage:[previewImageArray objectAtIndex:(6+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (7+page*12))
    {
        [_buttonImage8 setBackgroundImage:[previewImageArray objectAtIndex:(7+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (8+page*12))
    {
        [_buttonImage9 setBackgroundImage:[previewImageArray objectAtIndex:(8+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (9+page*12))
    {
        [_buttonImage10 setBackgroundImage:[previewImageArray objectAtIndex:(9+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (10+page*12))
    {
        [_buttonImage11 setBackgroundImage:[previewImageArray objectAtIndex:(10+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (11+page*12))
    {
        [_buttonImage12 setBackgroundImage:[previewImageArray objectAtIndex:(11+page*12)] forState:UIControlStateNormal];
    }
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)downloadImages {
    //PFUser *currentUser = [PFUser currentUser];
    PFUser *user = [PFUser currentUser];
    
    //PFQuery *query = [PFQuery queryWithClassName:@"images"];
    //PFRelation *relation = [user relationforKey:@"favoritesRelation"];
    
    //PFQuery *usersQuery = [PFQuery queryWithClassName:@"user"];
    PFQuery *imagesQuery = [PFQuery queryWithClassName:@"images"];
    NSArray *objects = [user objectForKey:@"favorites"];
    
    /*JSONobjects = [JSONobjects stringByReplacingOccurrencesOfString:@"[" withString:@""];
     JSONobjects = [JSONobjects stringByReplacingOccurrencesOfString:@"]" withString:@""];
     JSONobjects = [JSONobjects stringByReplacingOccurrencesOfString:@"\"" withString:@""];*/
    
    /*NSError *error = nil;
     NSArray *objects = [NSJSONSerialization JSONObjectWithData:JSONobjects options:NSJSONWritingPrettyPrinted error:&error];*/
    
    //NSArray *objects = [JSONobjects JSONValue];
    
    
    //NSArray *objects = [JSONobjects componentsSeparatedByString:@","];
    
    //[favs whereKey: containedIn:]
    //[query whereKey:@"ownerUsername" equalTo:currentUser.username];
    //NSArray * objects = user.favorites;
    imageArray = [[NSMutableArray alloc] init];
    dateArray = [[NSMutableArray alloc] init];
    previewImageArray = [[NSMutableArray alloc] init];
    descriptionArray = [[NSMutableArray alloc] init];
    userNameArray = [[NSMutableArray alloc] init];
    imageobjects = [[NSMutableArray alloc] init];
    
    
    
    //date, image, username, preview, description
    
    //[imagesQuery whereKey:@"objectId" containedIn:objects ];
    //[imagesQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    //if(!error) {
    // successfully downloaded images
    for(int i = 0; i < objects.count; ++i)
    {
        //create image object
        NSString *imageObjectString = [objects objectAtIndex:i];
        [imagesQuery whereKey:@"objectId" equalTo:imageObjectString];
        PFObject *imageObject = [imagesQuery getObjectWithId:imageObjectString];
        PFFile *imageFile = [imageObject objectForKey:@"pic"];
        NSData *imageData = [imageFile getData];
        
        PFFile* previewImageFile = [imageObject objectForKey:@"preview"];
        NSData *previewImageData = [previewImageFile getData];
        
        //store image information in arrays
        if (imageObject != nil)
        {
        [imageArray addObject:[UIImage imageWithData:imageData]];
        [descriptionArray addObject:[imageObject objectForKey:@"desc"]];
        [dateArray addObject:[imageObject createdAt]];
        [previewImageArray addObject:[UIImage imageWithData:previewImageData]];
        [userNameArray addObject:[imageObject objectForKey:@"ownerUsername"]];
        [imageobjects addObject:imageObject/*[objects objectAtIndex:i]*/];
        }
    }
    
    //Load buttons with images
    if([previewImageArray count] > (0+page*12))
    {
        [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:(0+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (1+page*12))
    {
        [_buttonImage2 setBackgroundImage:[previewImageArray objectAtIndex:(1+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (2+page*12))
    {
        [_buttonImage3 setBackgroundImage:[previewImageArray objectAtIndex:(2+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (3+page*12))
    {
        [_buttonImage4 setBackgroundImage:[previewImageArray objectAtIndex:(3+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (4+page*12))
    {
        [_buttonImage5 setBackgroundImage:[previewImageArray objectAtIndex:(4+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (5+page*12))
    {
        [_buttonImage6 setBackgroundImage:[previewImageArray objectAtIndex:(5+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (6+page*12))
    {
        [_buttonImage7 setBackgroundImage:[previewImageArray objectAtIndex:(6+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (7+page*12))
    {
        [_buttonImage8 setBackgroundImage:[previewImageArray objectAtIndex:(7+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (8+page*12))
    {
        [_buttonImage9 setBackgroundImage:[previewImageArray objectAtIndex:(8+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (9+page*12))
    {
        [_buttonImage10 setBackgroundImage:[previewImageArray objectAtIndex:(9+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (10+page*12))
    {
        [_buttonImage11 setBackgroundImage:[previewImageArray objectAtIndex:(10+page*12)] forState:UIControlStateNormal];
    }
    if([previewImageArray count] > (11+page*12))
    {
        [_buttonImage12 setBackgroundImage:[previewImageArray objectAtIndex:(11+page*12)] forState:UIControlStateNormal];
    }
    
    //load objecst
    //[imageobjects arrayByAddingObjectsFromArray:objects];
    
    /*} else {
     // error downloading images
     NSLog(@"Error downloading user's images.\n");*/
//}
//}];


/*[_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:3] forState:UIControlStateNormal];
 [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:4] forState:UIControlStateNormal];
 [_buttonImage1 setBackgroundImage:[previewImageArray objectAtIndex:5] forState:UIControlStateNormal];
 */
//}
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //set page
    page = 0;
    
    PFUser *user = [PFUser currentUser];
    [user refreshInBackgroundWithBlock:nil];
    
    //PFQuery *imagesQuery = [PFQuery queryWithClassName:@"images"];
    if ([user objectForKey:@"favorites"] != [NSNull null])
    {
        [self downloadImages];
    }
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

-(void)reload
{
    
}

- (void)viewDidUnload {
    [self setButtonImage1:nil];
    [self setButtonImage2:nil];
    [self setButtonImage3:nil];
    [self setButtonImage4:nil];
    [self setButtonImage5:nil];
    [self setButtonImage6:nil];
    [self setButtonImage7:nil];
    [self setButtonImage8:nil];
    [self setButtonImage9:nil];
    [self setButtonImage10:nil];
    [self setButtonImage11:nil];
    [self setButtonImage12:nil];
    [self setPrevious:nil];
    [self setNext:nil];
    [super viewDidUnload];
}
@end

/*
 //
 //  FavoritesViewController.m
 //  UCRInstagram
 //
 //  Created by Luis Roman on 2/22/13.
 //  Copyright (c) 2013 CS180Team7. All rights reserved.
 //
 
 #import "FavoritesViewController.h"
 #import "FavoritesCells.h"
 
 
 @interface FavoritesViewController ()
 
 @end
 
 @implementation FavoritesViewController
 
 //ctrl-x
 
 //Delegate Methods
 *-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
 {
 return 1;
 }
 
 -(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
 {
 return self.data_array.count;
 }
 
 -(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 FavoritesCells *aCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"firstCell" forIndexPath:indexPath];
 
 aCell.firstLabel.text = self.data_array[indexPath.row];
 
 return aCell;
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
 
 self.data_array =
 @[@"Jan", @"Feb", @"Mar", @"April", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
 
 
 }*
 
 - (void)didReceiveMemoryWarning
 {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 - (void)viewDidUnload {
 [self setFirstLabel:nil];
 [super viewDidUnload];
 }
 @end
 */