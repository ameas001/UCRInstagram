//
//  ExploreViewController.m
//  UCRInstagram
//
//  Created by Tony Albor on 2/14/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "ExploreViewController.h"

@interface ExploreViewController ()

@end

@implementation ExploreViewController
-(void)sendInfo:(int)i
{
    user_text = [[global_images objectAtIndex:i] objectForKey:@"ownerUsername"];
    camefrom = YES;
    PFFile *file_get = [[global_images objectAtIndex:i] objectForKey:@"pic"];
    NSData *data_get = [file_get getData];
    pass_image = [UIImage imageWithData:data_get];
    pass_desc = [[global_images objectAtIndex:i] objectForKey:@"desc"];
    pass_imageobject = [global_images objectAtIndex:i];
    
    PFObject *obj = [global_images objectAtIndex:i];
    NSDate *currentDate = obj.createdAt;
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
- (IBAction)refresh:(id)sender {
    UIStoryboard *st = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    UIViewController *lvc = [st instantiateViewControllerWithIdentifier:@"TabViewController"];
    [lvc setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:lvc animated:NO completion:nil];
}

- (IBAction)button1Action:(id)sender {
    [self sendInfo:0];
}
- (IBAction)button2Action:(id)sender {
    [self sendInfo:1];
}
- (IBAction)button3Action:(id)sender {
    [self sendInfo:2];
}
- (IBAction)button4Action:(id)sender {
    [self sendInfo:3];
}
- (IBAction)button5Action:(id)sender {
    [self sendInfo:4];
}
- (IBAction)button6Action:(id)sender {
    [self sendInfo:5];
}
- (IBAction)button7Action:(id)sender {
    [self sendInfo:6];
}
- (IBAction)button8Action:(id)sender {
    [self sendInfo:7];
}
- (IBAction)button9Action:(id)sender {
    [self sendInfo:8];
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
    
    //Create query to load 9 random images from parse
    NSMutableArray *image_store = [[NSMutableArray alloc]init];
    PFQuery *query = [PFQuery queryWithClassName:@"images"];
    
    //Hao's Addon///////////////////////////////////////////////////////////////////
    [query whereKey:@"everyone" equalTo:@"yes"];
    ///////////////////////////////////////////////////////////////////////
    
    //Limit query size
    query.limit = 15;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            //success
            NSMutableArray *int_store = [[NSMutableArray alloc]init];
            //Add objects to array
            for(int i=0; i< 10; i++){
                int randNum = rand() % ([objects count]-1);
                if([int_store count] > 0){
                    for(int j=0; j<[int_store count];j++){
                        NSNumber *check = [int_store objectAtIndex:j];
                        if(randNum == [check intValue]){
                            randNum = rand() % ([objects count]-1);
                            j=-1;
                        }
                    }
                }
                NSNumber *num = [NSNumber numberWithInt:randNum];
                [int_store addObject:num];
                [image_store addObject:[objects objectAtIndex:randNum]];
                NSLog(@"%d",randNum);
            }
            
            //Set pics of buttons to those objects in the array
            PFFile *file_get1 = [[image_store objectAtIndex:0] objectForKey:@"preview"];
            NSData *data_get1 = [file_get1 getData];
            [_button1 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:1] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button2 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:2] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button3 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:3] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button4 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:4] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button5 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:5] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button6 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:6] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button7 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:7] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button8 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            file_get1 = [[image_store objectAtIndex:8] objectForKey:@"preview"];
            data_get1 = [file_get1 getData];
            [_button9 setImage:[UIImage imageWithData:data_get1] forState:UIControlStateNormal];
            
            //Pass Array to global_images
            global_images = [NSMutableArray arrayWithArray:image_store];
        }
        else{
            //error
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setButton1:nil];
    [self setButton2:nil];
    [self setButton3:nil];
    [self setButton4:nil];
    [self setButton5:nil];
    [self setButton6:nil];
    [self setButton7:nil];
    [self setButton8:nil];
    [self setButton9:nil];
    [self setRefreshButton:nil];
    [super viewDidUnload];
}
@end