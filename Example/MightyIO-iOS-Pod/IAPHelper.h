//
//  IAPHelper.h
//  MightyIO-iOS-Pod
//
//  Created by John Bueno on 7/15/14.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
UIKIT_EXTERN NSString* const IAPHelperProductPurchasedNotification;

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray* products);

@interface IAPHelper : NSObject <SKProductsRequestDelegate, SKPaymentTransactionObserver>

- (id)initWithProductIdentifiers:(NSSet*)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
- (void)buyProduct:(SKProduct*)product;
- (BOOL)productPurchased:(NSString*)productIdentifier;

@end
