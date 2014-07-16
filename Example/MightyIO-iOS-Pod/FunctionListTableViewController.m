//
//  FunctionListTableViewController.m
//  MightyIO-iOS-Pod
//
//  Created by John Bueno on 7/14/14.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "FunctionListTableViewController.h"
#import <MightyIO/Mighty.h>

@interface FunctionListTableViewController ()

@end

@implementation FunctionListTableViewController

@synthesize products = _products;
@synthesize productsRequest = _productsRequest;
@synthesize purchasedProductIdentifiers = _purchasedProductIdentifiers;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getProductsFromiTunes];
}

#pragma mark - Get products from itunes

- (void)getProductsFromiTunes
{
    NSSet* productIdentifiers = [NSSet setWithObjects:
                                           @"com.supermighty.MightyIOiOS.magicboots",
                                           @"com.supermighty.MightyIOiOS.coinpurse2",
                                           nil];

    // Check for previously purchased products
    _purchasedProductIdentifiers = [NSMutableSet set];
    for (NSString* productIdentifier in productIdentifiers) {
        BOOL productPurchased = [[NSUserDefaults standardUserDefaults] boolForKey:productIdentifier];
        if (productPurchased) {
            [_purchasedProductIdentifiers addObject:productIdentifier];
            NSLog(@"Previously purchased: %@", productIdentifier);
        }
    }

    // Make call to iTunes for items
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)productsRequest:(SKProductsRequest*)request didReceiveResponse:(SKProductsResponse*)response
{
    _products = response.products;
}

- (BOOL)productPurchased:(NSString*)productIdentifier
{
    return [_purchasedProductIdentifiers containsObject:productIdentifier];
}

#pragma mark - Process completed purchases
- (void)buyProduct:(SKProduct*)product
{

    NSLog(@"Buying %@...", product.productIdentifier);

    SKPayment* payment = [SKPayment paymentWithProduct:product];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)paymentQueue:(SKPaymentQueue*)queue updatedTransactions:(NSArray*)transactions
{

    for (SKPaymentTransaction* transaction in transactions) {
        switch (transaction.transactionState) {
        // Call the appropriate custom method.
        case SKPaymentTransactionStatePurchased:
            [self completeTransaction:transaction];
            NSLog(@"PURCHASED %@", transaction);
            break;

        case SKPaymentTransactionStateFailed:
            NSLog(@"failedTransaction...");
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            break;

        case SKPaymentTransactionStateRestored:
            NSLog(@"restoreTransaction...");
            [self provideContentForProductIdentifier:transaction.originalTransaction.payment.productIdentifier];
            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];

        case SKPaymentTransactionStatePurchasing:
            NSLog(@"IN PURCHASING, %@", transaction);
            break;

        default:
            break;
        }
    }
}

// MAKE CALL TO SUPERMIGHTY THAT ITEM HAS BEEN PURCHASED
// IF ITEM PRODUCT ID IS REGESTERED AS A MIGHTY ITEM IT WILL BE RECORDED
- (void)completeTransaction:(SKPaymentTransaction*)transaction
{
    NSLog(@"completeTransaction...");
    NSLog(@"Product Identifier %@", transaction.payment.productIdentifier);
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];

    //If purchased coinpurse2 test processTransaction
    if ([transaction.payment.productIdentifier isEqualToString:@"com.supermighty.MightyIOiOS.coinpurse2"]) {
        [[Mighty sharedInstance] processTransaction:transaction];

        //If purchased coinpurse2 test processTransactionWithBlock
    } else if ([transaction.payment.productIdentifier isEqualToString:@"com.supermighty.MightyIOiOS.magicboots"]) {
        [[Mighty sharedInstance] processTransaction:transaction withBlock:^{
            UIAlertView *blockCompleteAlert = [[UIAlertView alloc] initWithTitle:@"Processed" message:@"SuperMighty has processed your transaction." delegate:self cancelButtonTitle:@"Close" otherButtonTitles: nil];
            [blockCompleteAlert show];
        }];
    }
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)provideContentForProductIdentifier:(NSString*)productIdentifier
{

    [_purchasedProductIdentifiers addObject:productIdentifier];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Call Mighty Methods

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    switch (indexPath.row) {
    // Get list of Mighty Items from themighty.io
    case 0:

        // NOTE: This is called on log in.  It should only be necessary to call this if you wish to update during app runtime
        // otherwise you can access the products by calling [Mighty sharedInstance].mightyItems
        [[Mighty sharedInstance] getProductListWithBlock:^(NSArray* objects, NSError* error) {
            if (!error) {
                NSMutableString* mightyItemsList = [NSMutableString string];
                for (NSDictionary* item in objects) {
                    [mightyItemsList appendString:[NSString stringWithFormat:@"%@ \n", [item objectForKey:@"productId"]]];
                };
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mighty Items List" message:mightyItemsList delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles: nil];
                [alert show];
            }
        }];

        break;

    // Process a single transation
    case 1:
        // Purcahse the first item returned from the itunes
        // Transaction is processed by SuperMighty using:
        // - (void)completeTransaction:(SKPaymentTransaction*)transaction;
        // Note: see - (void)completeTransaction:(SKPaymentTransaction*)transaction; for implementation
        [self buyProduct:[_products objectAtIndex:0]];

        break;

    // Process a single transation with block
    case 2:
        // Purchase the second item returned from itunes
        // Transaction is processed by SuperMighty using:
        // - (void)processTransaction:(SKPaymentTransaction*)transaction withBlock:(void (^)(void))block;
        // This can be used to fire an action such as sharing once SuperMighty has recorded the purchase
        // Note: see - (void)completeTransaction:(SKPaymentTransaction*)transaction; for implementation
        [self buyProduct:[_products objectAtIndex:1]];

        break;

    // Open Facebook Share Modal With Text
    case 3:
        // Opens a modal Facebook share in a specified ViewController with a default share text.
        // This can be called in the closure of:
        // - (void)processTransaction:(SKPaymentTransaction*)transaction withBlock:(void (^)(void))block;
        [[Mighty sharedInstance] openFacebookShareModalFromViewController:self withShareText:@"I just made a Mighty Purchase"];

        break;
    // Open Facebook Share Modal With Text
    case 4:
        // Opens a modal Facebook share in a specified ViewController. The default share text will be pulled from the API.
        // This can be called in the closure of:
        // - (void)processTransaction:(SKPaymentTransaction*)transaction withBlock:(void (^)(void))block;
        [[Mighty sharedInstance] openFacebookShareModalFromViewController:self];

        break;

    default:
        break;
    }
}

@end
