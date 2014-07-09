//
//  SuperMighty_iOS_SDK.h
//  SuperMighty-iOS-SDK
//
//  Created by Gavin Potts on 6/13/14.
//  Copyright (c) 2014 SuperMighty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
#import <Parse-iOS-SDK/Parse.h>

void _initWithUsernameAndPassword(const char* username, const char* password);

@interface SuperMightySDK : NSObject <SKProductsRequestDelegate> {
    SKProductsRequest* _productsRequest;
}

@property BOOL debug;
@property BOOL authenticating;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) NSArray* mightyItems;
@property (strong, nonatomic) PFObject* game;
@property SKPaymentTransaction* lastTransaction;
@property (strong, nonatomic) PFObject* currentItem;

// Init Functions
- (id)init;

+ (SuperMightySDK*)sharedInstance;

+ (SuperMightySDK*)initWithUsername:(NSString*)username andPassword:(NSString*)password;

// Product Getters
- (void)getProductListWithBlock:(void (^)(NSArray*, NSError*))block;

// Transactional Functions
- (void)processTransactions:(NSArray*)transactions;

- (void)processTransaction:(SKPaymentTransaction*)transaction;

// Dev Helpers
- (void)logMessage:(NSString*)message;

@end
