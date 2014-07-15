//
//  smIAPHelper.m
//  MightyIO-iOS-Pod
//
//  Created by John Bueno on 7/15/14.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "smIAPHelper.h"

@implementation smIAPHelper

+ (smIAPHelper*)sharedInstance
{
    static dispatch_once_t once;
    static smIAPHelper* sharedInstance;
    dispatch_once(&once, ^{
        NSSet * productIdentifiers = [NSSet setWithObjects:
                                      @"com.supermighty.MightyIOiOS.magicboots",
                                      @"com.supermighty.MightyIOiOS.coinpurse",
                                      nil];
        sharedInstance = [[self alloc] initWithProductIdentifiers:productIdentifiers];
    });
    return sharedInstance;
}

@end
