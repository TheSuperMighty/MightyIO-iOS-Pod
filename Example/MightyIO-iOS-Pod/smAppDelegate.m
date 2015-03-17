//
//  smAppDelegate.m
//  MightyIO-iOS-Pod
//
//  Created by CocoaPods on 07/09/2014.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "smAppDelegate.h"
#import <MightyIO-iOS-Pod/Mighty.h>

@implementation smAppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{

    [Mighty initWithAuthToken:@"0e6f04cd221351a7cef40d8b75689877"];

    return YES;
}

@end
