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
#import <Social/Social.h>
#import <Security/Security.h>
#import "Parse.h"
#import "SMRibbon.h"
//#import "SMUser.h"
//#import "SMGame.h"

@class PFObject;
@class Mighty;
@class SVProgressHUD;
@class SMUser;
@class SMGame;

@protocol MightyDelegate <NSObject>
@optional

- (void)mightyFinishedLoadingWithActiveCampaign:(BOOL)hasCampaign;
- (void)mightyModalOpen;
- (void)mightyModalClosed;

@required

- (void)mightyDidRecordSuccessfulTransaction:(SKPaymentTransaction*)transaction;
- (void)mightyTransactionFailedWithError:(NSError*)error;

@end

@interface Mighty : NSObject {
    __weak id<MightyDelegate> mightyDelegate;
}

@property (strong, nonatomic) SMGame* smGame;
@property (nonatomic, weak) id<MightyDelegate> mightyDelegate;
@property (strong, nonatomic) NSString* authToken;
@property (strong, nonatomic) NSString* versionNumber;
@property (strong, nonatomic) PFObject* completedPurchase;
@property (strong, nonatomic) SKPaymentTransaction* lastTransaction;
@property (strong, nonatomic) UIViewController* presentingViewController;
@property (strong, nonatomic) UIButton* smRibbon;
@property (strong, nonatomic) NSNumber* testing;
@property (strong, nonatomic) NSNumber* tweeted;
@property (strong, nonatomic) NSNumber* shared;

@property BOOL debug;
@property BOOL authenticating;
@property BOOL isCampaignActive;
@property BOOL simulator;
@property BOOL disableIAP;

@property SVProgressHUD* loader;

// Init Functions

/**
 Instantiate the Mighty class with a specified delegate
 @param delegateObject
 The object that will listen for various events and responses
 @return Mighty object with a delegate assigned for responses
 */
- (id)initWithDelegate:(id<MightyDelegate>)delegateObject;

/**
 Returns a singleton version of the Mighty class object
 @return The singleton @c Mighty object
 */
+ (Mighty*)sharedInstance;

/**
 Inits the Mighty class and logs into the MightyIO system with supplied auth token.
 @return The singleton @c Mighty object that can be used throughout the app
 */
+ (Mighty*)initWithAuthToken:(NSString*)token;

// Dev Helpers
/**
 Helper function to log debug messages
 @return void
 */
- (void)logMessage:(NSString*)message;

/**
 Helper function to create a ribbon on the viewcontroller supplied
 @return void
 */
- (void)makeRibbonWithCenter:(CGPoint)center inViewController:(UIViewController*)viewController;

/**
 Helper function to link Button outlet in presenting controller to SM ribbon
 @return void
 */
- (void)makeRibbonWithIBOutlet:(UIButton*)button inViewController:(UIViewController*)viewController;

/**
 Helper function to launch SuperMighty from custom event
 @return void
 */
- (void)startSuperMightyInViewController:(UIViewController*)viewController;

/**
 Helper function to show/hide ribbom based on item status
 @return void
 */
- (void)setRibbonVisibility;

/**
Show loader over overview until item is confirmed with Apple
 @return void
 */
- (void)loadOverViewInWindow:(UIWindow*)window;

@end
