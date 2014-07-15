//
//  smAppDelegate.m
//  MightyIO-iOS-Pod
//
//  Created by CocoaPods on 07/09/2014.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "smAppDelegate.h"
#import <MightyIO-iOS-Pod/Mighty.h>
#import "smIAPHelper.h"

@implementation smAppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{

    [smIAPHelper sharedInstance];

    [Mighty initWithUsername:@"test@supermighty.com" andPassword:@"scrapple"];

    return YES;
}

@end
