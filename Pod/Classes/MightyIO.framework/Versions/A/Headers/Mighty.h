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
#import "Parse.h"
#import <Social/Social.h>
#import <Security/Security.h>

@class Mighty;
@protocol MightyDelegate <NSObject>
@optional

- (void)didRecordSuccessfulTransaction:(SKPaymentTransaction*)transaction;

@end

@interface Mighty : NSObject <SKProductsRequestDelegate> {
    __weak id<MightyDelegate> mightyDelegate;
    SKProductsRequest* _productsRequest;
}
@property (nonatomic, weak) id<MightyDelegate> mightyDelegate;
@property BOOL debug;
@property BOOL authenticating;
@property (strong, nonatomic) NSString* username;
@property (strong, nonatomic) NSString* password;
@property (strong, nonatomic) NSArray* mightyItems;
@property (strong, nonatomic) PFObject* game;
@property (strong, nonatomic) PFObject* cause;
@property (strong, nonatomic) PFObject* item;
@property (strong, nonatomic) PFObject* currentItem;
@property SKPaymentTransaction* lastTransaction;
@property (strong, nonatomic) NSString* landingPageUrl;
@property (strong, nonatomic) NSURL* itemImageUrl;
@property (strong, nonatomic) NSString* dynamicShareText;
@property (strong, nonatomic) UIViewController* presentingViewController;

// Init Functions
- (id)initWithDelegate:(id<MightyDelegate>)delegateObject;

+ (Mighty*)sharedInstance;

+ (Mighty*)initWithUsername:(NSString*)username andPassword:(NSString*)password;

// Product Getters
- (void)getProductListWithBlock:(void (^)(NSArray*, NSError*))block;

// Transactional Functions
- (void)purchaseMightyItem:(PFObject*)item;

- (void)processTransaction:(SKPaymentTransaction*)transaction;

- (void)processTransaction:(SKPaymentTransaction*)transaction withBlock:(void (^)(void))block;

// Social Functions

- (void)openFacebookShareModalFromViewController:(UIViewController*)viewController withShareText:(NSString*)shareText;

- (void)openFacebookShareModalFromViewController:(UIViewController*)viewController;

// Dev Helpers
- (void)logMessage:(NSString*)message;

- (void)makeRibbonWithCenter:(CGPoint)center inViewController:(UIViewController*)viewController;

// Manually start SuperMighty
- (void)startSuperMightyInViewController:(UIViewController*)viewController;

@end
