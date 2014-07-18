//
//  FunctionListTableViewController.h
//  MightyIO-iOS-Pod
//
//  Created by John Bueno on 7/14/14.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface FunctionListTableViewController : UITableViewController <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (strong, nonatomic) NSArray* products;
@property (strong, nonatomic) SKProductsRequest* productsRequest;
@property (strong, nonatomic) NSMutableSet* purchasedProductIdentifiers;

@end
