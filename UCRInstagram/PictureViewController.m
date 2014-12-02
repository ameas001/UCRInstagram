//
//  PictureViewController.m
//  UCRInstagram
//
//  Created by user2349 on 2/8/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "PictureViewController.h"
#import "DescViewController.h"

@interface PictureViewController ()

@end

@implementation PictureViewController
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

-(void)resetFilter
{
    [_imageTakeButton setImage:profilePic forState:UIControlStateNormal];
}

- (IBAction)normalAction:(id)sender {
    //Setting image back to normal
    if(_imageTakeButton.currentImage != nil){
        [self resetFilter];
    }
}

- (IBAction)sepiaAction:(id)sender {
    //Change the image to sepia
    if(_imageTakeButton.currentImage != nil){
        [self resetFilter];
        CIImage *beginFilter = [[CIImage alloc] initWithImage:_imageTakeButton.currentImage];
        CIFilter *sepiaFilter = [CIFilter filterWithName:@"CISepiaTone" keysAndValues:kCIInputImageKey, beginFilter, nil];
        CIImage *finalFilter = [sepiaFilter outputImage];
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imgref = [context createCGImage:finalFilter fromRect:[finalFilter extent]];
        [_imageTakeButton setImage:[UIImage imageWithCGImage:imgref] forState:UIControlStateNormal];
        CGImageRelease(imgref);
    }
}

- (IBAction)b52Action:(id)sender {
    if(_imageTakeButton.currentImage != nil){
        [self resetFilter];
        CIImage *beginFilter = [[CIImage alloc] initWithImage:_imageTakeButton.currentImage];
        CIFilter *b52Filter = [CIFilter filterWithName:@"CIColorMatrix"];
        [b52Filter setValue:beginFilter forKey:kCIInputImageKey];
        [b52Filter setValue:[CIVector vectorWithX:1.5 Y:0 Z:0 W:0] forKey:@"inputRVector"];
        [b52Filter setValue:[CIVector vectorWithX:0 Y:1.5 Z:0 W:0] forKey:@"inputGVector"];
        [b52Filter setValue:[CIVector vectorWithX:0 Y:0 Z:.66 W:0] forKey:@"inputBVector"];
        [b52Filter setValue:[CIVector vectorWithX:0 Y:0 Z:0 W:1] forKey:@"inputAVector"];
        CIImage *finalFilter = [b52Filter outputImage];
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imgref = [context createCGImage:finalFilter fromRect:[finalFilter extent]];
        [_imageTakeButton setImage:[UIImage imageWithCGImage:imgref] forState:UIControlStateNormal];
        CGImageRelease(imgref);
    }
}


- (IBAction)sharpenAction:(id)sender {
    if(_imageTakeButton.currentImage != nil){
        [self resetFilter];
        NSNumber *inten = [NSNumber numberWithInt:1];
        CIImage *beginFilter = [[CIImage alloc] initWithImage:_imageTakeButton.currentImage];
        CIFilter *sharpenFilter = [CIFilter filterWithName:@"CISharpenLuminance"];
        [sharpenFilter setValue:beginFilter forKey:kCIInputImageKey];
        [sharpenFilter setValue:inten forKey:@"inputSharpness"];
        
        CIImage *finalFilter = [sharpenFilter outputImage];
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imgref = [context createCGImage:finalFilter fromRect:[finalFilter extent]];
        [_imageTakeButton setImage:[UIImage imageWithCGImage:imgref] forState:UIControlStateNormal];
        CGImageRelease(imgref);
    }
    
    
}


- (IBAction)monoAction:(id)sender {
    if(_imageTakeButton.currentImage != nil){
        [self resetFilter];
        NSNumber *inten = [NSNumber numberWithInt:1];
        CIColor *colorM = [[CIColor alloc]initWithColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
        CIImage *beginFilter = [[CIImage alloc] initWithImage:_imageTakeButton.currentImage];
        CIFilter *monoFilter = [CIFilter filterWithName:@"CIColorMonochrome"];
        [monoFilter setValue:beginFilter forKey:kCIInputImageKey];
        [monoFilter setValue:inten forKey:@"inputIntensity"];
        [monoFilter setValue:colorM forKey:@"inputColor"];
        CIImage *finalFilter = [monoFilter outputImage];
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef imgref = [context createCGImage:finalFilter fromRect:[finalFilter extent]];
        [_imageTakeButton setImage:[UIImage imageWithCGImage:imgref] forState:UIControlStateNormal];
        CGImageRelease(imgref);
    }
    
}




- (IBAction)visibleAction:(id)sender {
    if([visibleEveryone isEqualToString:@"yes"]){
        visibleEveryone = @"no";
        [_visibleButton setTitle:@"Visible: Friends" forState:UIControlStateNormal];
    }
    else{
        visibleEveryone = @"yes";
        [_visibleButton setTitle:@"Visible: Everyone" forState:UIControlStateNormal];    }
}


- (IBAction)imageTakeAction:(id)sender {
    //Action sheet pop-up to choose where you want your image to come from
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Photo From" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Library", nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //Starts at the top (Take photo=0, choose=1, cancel=2)
    if(buttonIndex == 0){
        //take photo
        [self startCameraControllerFromViewController: self
                                        usingDelegate: self];
        useCamera = YES;
    }
    if(buttonIndex == 1){
        //choose from library using image picker controller
        NSLog(@"choose");
        imagePicker.delegate=self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        useCamera = NO;
        [self presentModalViewController:imagePicker animated:YES];
        
    }
}

- (BOOL)startCameraControllerFromViewController: (UIViewController*) controller
                                  usingDelegate: (id <UIImagePickerControllerDelegate,
                                                  UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =[NSArray arrayWithObjects:(NSString *) kUTTypeImage,nil];
    // Allow editing
    cameraUI.allowsEditing = YES;
    
    cameraUI.delegate = delegate;
    
    [controller presentModalViewController: cameraUI animated: YES];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //Finish picking photo from library
    UIImage *photo_pick;
    NSURL *mediaURL;
    mediaURL = (NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
    photo_pick = (UIImage *)[info valueForKey:UIImagePickerControllerEditedImage];
    //save image to global
    profilePic = photo_pick;
    if(useCamera){
        UIImageWriteToSavedPhotosAlbum (profilePic, nil, nil , nil);
    }
    [_imageTakeButton setImage:photo_pick forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //Dismiss MVC for imagepicker
    [picker dismissModalViewControllerAnimated:YES];
}

- (IBAction)sendButtonAction:(id)sender {
    [_descText resignFirstResponder];
    
    //Stock image from picture starup
    UIImage *image_stock = [UIImage imageNamed:@"camnophoto200.png"];
    
    //check if user has selected an image and description
    if(_imageTakeButton.currentImage != nil && _descText.text.length > 0 && _imageTakeButton.currentImage != image_stock){
        //Create image object
        PFUser *currentUser = [PFUser currentUser];
        PFObject *imageObj = [PFObject objectWithClassName:@"images"];
        [imageObj setObject:[currentUser objectForKey:@"username"] forKey:@"ownerUsername"];
        NSData *ppData = UIImagePNGRepresentation(_imageTakeButton.currentImage);
        PFFile *ppFile = [PFFile fileWithName:@"pic" data:ppData];
        [ppFile save];
        
        //We need a preview image to increase load time on app
        UIImage *temp = _imageTakeButton.currentImage;
        CGSize size = CGSizeMake(100, 100);
        UIGraphicsBeginImageContext(size);
        [temp drawInRect:CGRectMake(0, 0, size.width, size.height)];
        temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *preData = UIImagePNGRepresentation(temp);
        PFFile *preFile = [PFFile fileWithName:@"pre" data:preData];
        
        //GPS location
        //Reset here
        NSLog(@"City: %@",userCity);
        NSLog(@"State: %@", userState);
        
        
        //Saving image object
        [imageObj setObject:ppFile forKey:@"pic"];
        [imageObj setObject:_descText.text forKey:@"desc"];
        [imageObj setObject:preFile forKey:@"preview"];
        [imageObj setObject:visibleEveryone forKey:@"everyone"];
        [imageObj setObject:userCity forKey:@"city"];
        [imageObj setObject:userState forKey:@"state"];
        [imageObj saveInBackground];
        
        //Pass in values to the enhanced view
        //User name
        PFUser *current = [PFUser currentUser];
        user_text = [current objectForKey:@"username"];
        camefrom = YES;
        pass_image = _imageTakeButton.currentImage;
        pass_desc = _descText.text;
        pass_imageobject = imageObj;
        
        //Get current date
        NSDate *currentDate = [NSDate date];
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
    else{
        //No image or description was selected
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Upload Failed" message:@"Please take a photo and add a description." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    //For description. Placeholder.
    _descText.text = @"";
    _descText.textColor = [UIColor blackColor];
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    //For description. Acts like a placeholder.
    if(_descText.text.length == 0){
        _descText.textColor = [UIColor lightGrayColor];
        _descText.text = @"Description...";
        [_descText resignFirstResponder];
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

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    //For the description field. Resign keyboard if they return.
    if([text isEqualToString:@"\n"]) {
        [_descText resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    
    [locationMan stopUpdatingLocation];
    NSLog(@"HEYEHEYHEYE");
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error){
        for(CLPlacemark *placemark in placemarks){
            userCity = [placemark locality];
            userState = [placemark administrativeArea];
        }
    }];
    if(local == nil){
        local = newLocation;
    }
    [locationMan startUpdatingLocation];
}

- (void)viewDidLoad
{
    //for the image picker
    imagePicker = [[UIImagePickerController alloc]init];
    
    //for the description field
    _descText.text = @"Description...";
    _descText.textColor = [UIColor lightGrayColor];
    
    //Is the image visible to everyone
    visibleEveryone = @"yes";
    
    //GPS location start
    locationMan = [[CLLocationManager alloc]init];
    [locationMan startUpdatingLocation];
    [self locationManager:locationMan didUpdateToLocation:[locationMan location] fromLocation:nil];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    camefrom = NO;
    self.descText.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDescText:nil];
    [self setSendButton:nil];
    [self setImageTakeButton:nil];
    [self setVisibleButton:nil];
    [self setNormalButton:nil];
    [self setSepiaButton:nil];
    [self setSharpenButton:nil];
    [self setB52Button:nil];
    [self setMonoButton:nil];
    [super viewDidUnload];
}
@end
