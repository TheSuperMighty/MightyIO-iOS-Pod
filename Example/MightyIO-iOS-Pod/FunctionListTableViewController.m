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
    [self provideContentForProductIdentifier:transaction.payment.productIdentifier];

    //Call SuperMighty to process the transaction
    [[Mighty sharedInstance] processTransaction:transaction];
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

- (void)provideContentForProductIdentifier:(NSString*)productIdentifier
{

    [_purchasedProductIdentifiers addObject:productIdentifier];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:productIdentifier];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    switch (indexPath.row) {

    // Get list of Mighty Items from themighty.io
    case 0:

        // NOTE: This is called on log in.  It should only be necessary to call this if you wish to update during app runtime
        // otherwise you can access the products by calling [Mighty sharedInstance].mightyItems
        [[Mighty sharedInstance] getProductListWithBlock:^(NSArray* objects, NSError* error) {
            if (!error) {
                NSLog(@"Mighty Items %@", objects);
            }
        }];
        break;

    // Process a single transation
    case 1:
        // Purcahse the first item returned from the itunes
        // Transaction is processed by SuperMighty in - (void)completeTransaction:(SKPaymentTransaction*)transaction;
        // completeTransaction is called by - (void)paymentQueue:(SKPaymentQueue*)queue updatedTransactions:(NSArray*)transactions;
        [self buyProduct:[_products objectAtIndex:0]];

        break;

    // Process a single transation
    case 2:
        // Purcahse the first item returned from the itunes
        // Array of transactions is processed by SuperMighty in - (void)processTransactions:(NSArray*)transactions;
        // This is not typically used because in most cases it should be verified that a purcha
        [self buyProduct:[_products objectAtIndex:0]];

        break;

    default:
        break;
    }
}

@end
