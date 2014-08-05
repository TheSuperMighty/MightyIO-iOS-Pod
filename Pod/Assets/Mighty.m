//
//  SuperMighty_iOS_SDK.m
//  SuperMighty-iOS-SDK
//
//  Created by Gavin Potts on 6/13/14.
//  Copyright (c) 2014 SuperMighty. All rights reserved.
//
#import <Security/Security.h>
#import "Mighty.h"
#import "OverviewViewController.h"
#import "GiveViewController.h"
#import "VerificationController.h"

@implementation Mighty
@synthesize debug = _debug;
@synthesize mightyItems = _mightyItems;
@synthesize username = _username;
@synthesize password = _password;
@synthesize lastTransaction = _lastTransaction;
@synthesize currentItem = _currentItem;
@synthesize landingPageUrl = _landingPageUrl;
@synthesize dynamicShareText = _dynamicShareText;
@synthesize presentingViewController = _presentingViewController;
@synthesize mightyDelegate;

- (id)initWithDelegate:(id<MightyDelegate>)delegateObject
{
    self = [super init];
    if (self) {
        self.mightyDelegate = delegateObject;
    }
    return self;
}

+ (Mighty*)sharedInstance
{

    static dispatch_once_t onceToken = 0;

    __strong static id _sharedObject = nil;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

+ (Mighty*)initWithUsername:(NSString*)username andPassword:(NSString*)password
{

    [Mighty sharedInstance].debug = YES;
    [Mighty sharedInstance].username = username;
    [Mighty sharedInstance].password = password;
    [[Mighty sharedInstance] authenticateGame];
    return [Mighty sharedInstance];
}

- (void)authenticateGame
{
    if (![Mighty sharedInstance].authenticating) {

        [Mighty sharedInstance].authenticating = YES;

// TODO:  CHANGE THESE TO PRODUCTION KEYS BEFORE MERGING WITH MASTER

// DEVELOPMENT API KEY

#warning This must be changed to production before deployment
        [Parse setApplicationId:@"r94yfh6qLfmXSBF5rpbop1CLcCM4Z7W70TMbuNQT"
                      clientKey:@"Q98ulFoh9uw1XvukFzFKfMZZsTkPGSDCh2EvzLLJ"];

        // PRODUCTION API KEY
        //[Parse setApplicationId:@"5y0RAdTmI4AnlFnjCseZgpOf4vFkopSJYVCQ4uQl"
        //              clientKey:@"7NZkuIMk0TqosSfaoJX1YQoAK7012KjeVXRtY5Br"];

        [self logMessage:@"Attempting Login"];

        [PFUser logInWithUsernameInBackground:[Mighty sharedInstance].username
                                     password:[Mighty sharedInstance].password
                                        block:^(PFUser* user, NSError* error) {
                                            [self logMessage:@"Login Response Recieved"];
                                            [Mighty sharedInstance].authenticating = NO;
                                            if(!error){
                                                
                                                // GET THE GAME
                                                [[Mighty sharedInstance] getGameWithBlock:^(NSArray *objects, NSError *error) {
                                                    
                                                    if(!error){
                                                        
                                                        // GET THE PRODUCT LIST
                                                        [[Mighty sharedInstance] getProductListWithBlock:^(NSArray *objects, NSError *error) {
                                                        
                                                            [self logMessage:@"SuperMighty now ready"];
                                                        
                                                        }];
                                                    } else {
                                                        NSLog(@"SuperMighty Error: %@", error);
                                                    }
                                                
                                                }];
                                            } else {
                                                [self logMessage:@"Login Error"];
                                            }
                                        }];
    }
}

- (void)getGameWithBlock:(void (^)(NSArray*, NSError*))block
{

    NSString* bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];

    PFQuery* query = [PFQuery queryWithClassName:@"Game"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query whereKey:@"bundleIdentifier" equalTo:bundleIdentifier];
    [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error) {
        [self logMessage:@"Successfully requested games"];
        if(!error){
            if(objects.firstObject){
                [self logMessage:@"Game Found"];
                [Mighty sharedInstance].game = objects.firstObject;
                
                //Set landing page url for sharing
                _landingPageUrl = [[objects firstObject] objectForKey:@"landingPageUrl"];
                block(objects, nil);
            } else {
                NSMutableDictionary* details = [NSMutableDictionary dictionary];
                [details setValue:@"No games found in your account for this bundle identifier" forKey:NSLocalizedDescriptionKey];
                NSError *error = [NSError errorWithDomain:@"parse" code:401 userInfo:details];
                block(nil, error);
            }
            
        } else {
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:@"No games found in your account for this bundle identifier" forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"parse" code:401 userInfo:details];
            block(nil, error);
        }
    }];
}

- (void)getProductListWithBlock:(void (^)(NSArray*, NSError*))block
{
    _mightyItems = [[NSArray alloc] init];
    PFQuery* query = [PFQuery queryWithClassName:@"Item"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query whereKey:@"game" equalTo:self.game];
    [query includeKey:@"cause"];
    [query setCachePolicy:kPFCachePolicyNetworkElseCache];
    [query findObjectsInBackgroundWithBlock:^(NSArray* objects, NSError* error) {
        [self logMessage:@"Successfully requested products"];
        if (!error) {
            [self logMessage:[NSString stringWithFormat:@"%lu Products Found", (unsigned long)objects.count]];
            //Right now there should only be one mighty item per game
            [Mighty sharedInstance].mightyItems = [[NSArray alloc] initWithArray:objects];
            
            //Set shareText and cause from item
            [Mighty sharedInstance].cause = [[objects firstObject] objectForKey:@"cause"];
            _dynamicShareText = [[objects firstObject] objectForKey:@"shareText"];
            
            //Get item image
            PFFile *itemImage = [[objects firstObject] objectForKey:@"image"];
            [Mighty sharedInstance].itemImageUrl = [NSURL URLWithString:itemImage.url];
            
            //Create NSSet of product identifiers
            NSSet* productIdentifiers = [NSSet setWithObjects:
                                         [objects.firstObject objectForKey:@"productId"],
                                         nil];
            
            //Create Callback to run when item is purchased
            [PFPurchase addObserverForProduct:[objects.firstObject objectForKey:@"productId"] block:^(SKPaymentTransaction *transaction) {
                
                //When succesful purchase then log to SM
                [self processTransaction:transaction withBlock:^{
                    
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"SM_Push_Success"
                     object:self];

                    [mightyDelegate didRecordSuccessfulTransaction:transaction];
                }];
                
            }];
            
            // Make call to iTunes to fill in price and app data
            _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
            _productsRequest.delegate = self;
            [_productsRequest start];
            
            block(objects, nil);
            
        } else {
            [self logMessage:[NSString stringWithFormat:@"Error retrieving products: %@ %@", error, [error userInfo]]];
            block(nil, error);
        }
    }];
}

//Buy the mighty item using the parse store kit.
- (void)purchaseMightyItem:(PFObject*)item
{
    [PFPurchase buyProduct:[item objectForKey:@"productId"] block:^(NSError* error) {
        if (!error) {
            NSLog(@"%@, successfully purchased", [item objectForKey:@"productId"]);
        }else{
            NSLog(@"Error %@", error);
        }
    }];
}

// This is called from parse storekit observer
// Loops through list of mighty items and if the productId of the transaction matches the productId of a regestered MI it records to SM API
- (void)processTransaction:(SKPaymentTransaction*)transaction
{

    for (PFObject* item in [Mighty sharedInstance].mightyItems) {
        if ([[item objectForKey:@"productId"] isEqualToString:transaction.payment.productIdentifier]) {

            _lastTransaction = transaction;
            //Validate receipt block here.  Only save when this is complete with blank receipt if not valid or with json string if receipt not valid
            [[VerificationController sharedInstance] encodeReceiptForTransaction:transaction withBlock:^(NSMutableDictionary* receiptDictionary, NSError* error) {
                if (!error) {

                //Build a parse object of the purchase class from the purchased mighty item
                PFObject* purchaseObject = [PFObject objectWithClassName:@"Purchase"];
                [purchaseObject setObject:[item objectForKey:@"testing"] forKey:@"testing"];
                [purchaseObject setObject:[item objectForKey:@"productId"] forKey:@"productId"];
                [purchaseObject setObject:[item objectForKey:@"price"] forKey:@"price"];
                [purchaseObject setObject:item forKey:@"item"];

                //Pass receipt JSON string to parse for validation after save
                [purchaseObject setObject:receiptDictionary forKey:@"receipt"];

                // If there is an originalTransaction save this as the transactionId
                // this means that it is a duplicate purchase
                if (_lastTransaction.originalTransaction.transactionIdentifier) {
                    [purchaseObject setObject:_lastTransaction.originalTransaction.transactionIdentifier forKey:@"transactionId"];
                } else {
                    [purchaseObject setObject:_lastTransaction.transactionIdentifier forKey:@"transactionId"];
                }

                [purchaseObject setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] forKey:@"App"];
                [purchaseObject setACL:[PFACL ACLWithUser:[PFUser currentUser]]];
                [purchaseObject saveInBackgroundWithBlock:nil];

                //If a valid receipt does not exist save the transaction to the Parse error table instead
                }else{
                PFObject* errorObject = [PFObject objectWithClassName:@"Error"];
                [errorObject setObject:[item objectForKey:@"testing"] forKey:@"testing"];
                [errorObject setObject:[item objectForKey:@"productId"] forKey:@"productId"];
                [errorObject setObject:[item objectForKey:@"price"] forKey:@"price"];
                [errorObject setObject:item forKey:@"item"];
                [errorObject setObject:_lastTransaction.transactionIdentifier forKey:@"transactionId"];
                [errorObject setObject:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"] forKey:@"App"];
                [errorObject setACL:[PFACL ACLWithUser:[PFUser currentUser]]];
                [errorObject saveInBackgroundWithBlock:nil];

                }
            }];
        }
    }
}

// Calls processTransaction which records the purchase with super mighty and returns closure.
- (void)processTransaction:(SKPaymentTransaction*)transaction withBlock:(void (^)(void))block
{
    [self processTransaction:transaction];
    block();
}

// SK delegate function that retreives the IAP items from Apple
// If any of the IAPs are Mighty items the testing, price, and item properties are set
// The item property is also set at this point which is just the first item in the Mighty item list
// Starting out each game should only have one mighy item at a time
- (void)productsRequest:(SKProductsRequest*)request didReceiveResponse:(SKProductsResponse*)response
{
    _productsRequest = nil;
    //Loop through store and set price
    NSArray* skProducts = response.products;
    for (SKProduct* skProduct in skProducts) {
        NSString* productId = skProduct.productIdentifier;

        for (PFObject* mightyItem in [Mighty sharedInstance].mightyItems) {
            if ([[mightyItem objectForKey:@"productId"] isEqualToString:productId]) {

                NSNumber* testing;
                if ([[NSBundle mainBundle] pathForResource:@"embedded"
                                                    ofType:@"mobileprovision"]) {
                    testing = [NSNumber numberWithBool:YES];
                } else {
                    testing = [NSNumber numberWithBool:NO];
                }

                [mightyItem setObject:testing forKey:@"testing"];
                [mightyItem setObject:skProduct.price forKey:@"price"];
                [mightyItem setObject:mightyItem forKey:@"item"];
            }
        }
    }
    //This will be subject to change when games can have more than one item at a time
    [Mighty sharedInstance].item = [Mighty sharedInstance].mightyItems.firstObject;
}

- (void)openFacebookShareModalFromViewController:(UIViewController*)viewController
{
    [self postToFacebookWithShareText:_dynamicShareText inViewController:viewController];
}

- (void)openFacebookShareModalFromViewController:(UIViewController*)viewController withShareText:(NSString*)shareText
{
    [self postToFacebookWithShareText:shareText inViewController:viewController];
}

- (void)postToFacebookWithShareText:(NSString*)shareText inViewController:(UIViewController*)viewController
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController* mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];

        [mySLComposerSheet setInitialText:shareText];

        [mySLComposerSheet addURL:[NSURL URLWithString:_landingPageUrl]];

        [viewController presentViewController:mySLComposerSheet animated:NO completion:nil];
    } else {

        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Facebook Required" message:@"Please setup Facebook in your phone before sharing (Settings > Facebook)" delegate:viewController cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)makeRibbonWithCenter:(CGPoint)center inViewController:(UIViewController*)viewController
{
    UIButton* ribbon = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 71, 86)];
    [ribbon setBackgroundImage:[UIImage imageNamed:@"ribbon.png"] forState:UIControlStateNormal];
    [viewController.view addSubview:ribbon];
    _presentingViewController = viewController;
    [ribbon setCenter:center];
    [ribbon addTarget:self action:@selector(showSuperMightyModal) forControlEvents:UIControlEventTouchUpInside];
}

- (void)startSuperMightyInViewController:(UIViewController*)viewController
{
    _presentingViewController = viewController;
    [self showSuperMightyModal];
}

- (void)showSuperMightyModal
{
    NSLog(@"Begin SuperMighty");
    OverviewViewController* overviewViewController = [[OverviewViewController alloc] initWithNibName:@"OverviewViewController" bundle:nil];

    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:overviewViewController];
    [navigationController setNavigationBarHidden:YES];

    [_presentingViewController presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - Debugger -
- (void)logMessage:(NSString*)message
{
    if (self.debug) {
        NSLog(@"SuperMighty: %@", message);
    }
}

@end
