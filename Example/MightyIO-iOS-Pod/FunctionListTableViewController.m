//
//  FunctionListTableViewController.m
//  MightyIO-iOS-Pod
//
//  Created by John Bueno on 7/14/14.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "FunctionListTableViewController.h"
//#import "smIAPHelper.h"
#import <MightyIO/Mighty.h>

@interface FunctionListTableViewController ()

@end

@implementation FunctionListTableViewController

@synthesize products = _products;
@synthesize productsRequest = _productsRequest;

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self getProductsFromiTunes];
}

- (void)getProductsFromiTunes
{
    NSSet* productIdentifiers = [NSSet setWithObjects:
                                           @"com.supermighty.MightyIOiOS.magicboots",
                                           @"com.supermighty.MightyIOiOS.coinpurse",
                                           nil];
    _productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    _productsRequest.delegate = self;
    [_productsRequest start];
}

- (void)productsRequest:(SKProductsRequest*)request didReceiveResponse:(SKProductsResponse*)response
{
    _products = response.products;
}

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
        case SKPaymentTransactionStatePurchased:
            NSLog(@"Purchase success");
            break;
        case SKPaymentTransactionStateFailed:
            NSLog(@"Purchase failed");
            break;
        case SKPaymentTransactionStateRestored:
            NSLog(@"Purchase restored");
        default:
            break;
        }
    };
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
        [self buyProduct:[_products objectAtIndex:0]];

        break;

    default:
        break;
    }
}

@end
