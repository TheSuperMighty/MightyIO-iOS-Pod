//
//  FunctionListTableViewController.m
//  MightyIO-iOS-Pod
//
//  Created by John Bueno on 7/14/14.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "FunctionListTableViewController.h"
#import "smIAPHelper.h"
#import <MightyIO/Mighty.h>

@interface FunctionListTableViewController ()

@end

@implementation FunctionListTableViewController

@synthesize products = _products;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Call itunes connect via IAPHelper
    // Returns: A list of In App Purchases from itunes connect
    [[smIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray* products) {
        if (success) {
            _products = products;
            NSLog(@"Products from app store %@", _products);
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productPurchased:) name:IAPHelperProductPurchasedNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)productPurchased:(NSNotification*)notification
{

    NSString* productIdentifier = notification.object;
    [_products enumerateObjectsUsingBlock:^(SKProduct* product, NSUInteger idx, BOOL* stop) {
        if ([product.productIdentifier isEqualToString:productIdentifier]) {
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            *stop = YES;
        }
    }];
}

#pragma mark - Table view data source

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    //    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    //    NSString* functionName = cell.textLabel.text;

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
        NSLog(@"TEST1");
        break;

    default:
        break;
    }
}

@end
