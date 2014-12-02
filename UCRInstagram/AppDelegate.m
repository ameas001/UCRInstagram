//
//  AppDelegate.m
//  UCRInstagram
//
//  Created by Tony Albor on 1/25/13.
//  Copyright (c) 2013 CS180Team7. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Parse information
    [Parse setApplicationId:@"3JsH22DZGtCYAsB9hkCS6m0uC1YZ8robNfFunICr" clientKey:@"YyQKflgOmnSFUMjv1JlLlssa7SsjgjOFvSpGvg3p"];
    
    return YES;
}
@end
