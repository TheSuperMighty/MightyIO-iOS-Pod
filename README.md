MightyIO - iOS
=====================
The Mighty will provide you with the methods you need to easily interface with the SuperMighty API.  It contains methods to log in, get mighty items, record purchases of mighty items, and prompt a user to share the purchase of a mighty item.

## Quick Start Guide
1. Add 'MightyIO' to your Podfile
2. Run Pod install (Refer to CocoaPod’s [Getting Started Guide](http://cocoapods.org/#getstarted) for detailed instructions.)
3. Import Mighty ``#import <MightyIO-iOS-Pod/Mighty.h>``
4. Add ``[Mighty initWithUsername:@"supermighty" andPassword:@"scrapple"];`` to - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions;
5. Add ``[[Mighty sharedInstance] processTransactions:transactions];`` to -(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
6. To share a transaction in the closure of - (void)processTransaction:(SKPaymentTransaction*)transaction withBlock:(void (^)(void))block; call ``[[Mighty sharedInstance] openFacebookShareModalFromViewController:myRootViewController];``


Installation
-----
1. Install the Mighty to your project from cocopods at: http://cocoapods.org/?q=mighty
2. Import the Mighty to your project: `#import <MightyIO-iOS-Pod/Mighty.h>`
3. Before instantiating Mighty you must first register at http://themighty.io
* Create an account.
* Add a game (the name of your game must match your bundleIdentifier).
* Add items to your game
4. In your AppDelegate in the didFinishLaunchingWithOptions method instantiate the Mighty:
    
    ```objective-c
    - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
    {
        [Mighty initWithUsername:@"username" andPassword:@"password"];
        // Override point for customization after application launch.
        return YES;
    }
    ```

5. To verify that Mighty is running run your app and a series of messages should log to the console indicating successful log in and retrieval of you Mighty Items for that game.

Methods
-----
The Mighty contains several public methods that will allow you to:

* Log in
* List your mighty items
* Process a Mighty Transaction
* Prompt a user to share a Mighty purchase

###Init Functions
**+ (Mighty*)sharedInstance;**
An class method that returns a shared instance of the Mighty.

**returns:**

* (Mighty*)sharedInstance - a shared instance of Mighty

**example:**
```objective-c 
    [[Mighty sharedInstance] getProductListWithBlock:^(NSArray *products, NSError *error) {
        NSLog(@"PRODUCTS %@", products);
    }];
```
---

**+ (Mighty*)initWithUsername:(NSString*)username andPassword:(NSString*)password;**  
An class method logs into the Mighty. On log in this method will get your game, its share url and text, and its associated items. 

**params:**

* (NSString*)username - SuperMighty username
* (NSString*)password - SuperMighty password

**example:**
```objective-c
    - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
    {
        [Mighty initWithUsername:@"username" andPassword:@"password"];
        // Override point for customization after application launch.
        return YES;
    }
```

---

###Transactional Functions
**- (void)processTransactions:(NSArray*)transactions;**
An instance method that will process an NSArray of SKPaymentTransactions and record any purchase of a Mighty Item to the SuperMighty API.  Use this method was intended for use inside the SKPaymentTransactionObserver delegate function: ``-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;``

**params:**

(NSArray*)transactions - An array of SKPaymentTransactions.

**example:**
```objective-c
    -(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
        [[Mighty sharedInstance] processTransactions:transactions];
    }
```

---

**- (void)processTransaction:(SKPaymentTransaction*)transaction;**
Similar to ``- (void)processTransactions:(NSArray*)transactions;`` this method will process a single SKPaymentTransaction.

**params:**

* (SKPaymentTransaction*)transaction - A processed transaction from the app store.

**example:**
```objective-c
    -(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
        for (SKPaymentTransaction* transaction in transactions)
            [[Mighty sharedInstance] processTransaction:transaction];
    }
```

---

**- (void)processTransaction:(SKPaymentTransaction*)transaction withBlock:(void (^)(void))block;**
Similar to ``- (void)processTransactions:(SKPaymentTransaction*)transaction;`` this method will process a single SKPaymentTransaction and return a block when it completes.

**params:**

* (SKPaymentTransaction*)transaction - A processed transaction from the app store.

**example:**
```objective-c
    -(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
        for (SKPaymentTransaction* transaction in transactions){
            [[Mighty sharedInstance] processTransaction:transaction withBlock:^{
            
                UIAlertView *SuperMightySuccess = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Super Mighty Processed" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: @"Share To Facebook", nil];
                [SuperMightySuccess show];
            
        }];
        }
    }
```

---

###Social Functions

**- (void)openFacebookShareModalFromViewController:(UIViewController*)viewController withShareText:(NSString*)shareText;**

Opens a modal Facebook share in a specified ViewController with a default share text.

**params:**

* (UIViewController*)viewController - The ViewController that will present the sharing modal.
* (NSString*)shareText - The default share text. **If this parameter is empty the share text will pull from the SuperMighty API.**

**example:**
```objective-c
    // Get Root View Controller
    UIViewController* myRootViewController = self.window.rootViewController;
    
    // Present sharing modal on myRootViewController
    [[Mighty sharedInstance] openFacebookShareModalFromViewController:myRootViewController withShareText:@"Share Text"];
```

---

**- (void)openFacebookShareModalFromViewController:(UIViewController*)viewController;**

Opens a modal Facebook share in a specified ViewController.  The default share text will be pulled from the API.

**params:**

* (UIViewController*)viewController - The ViewController that will present the sharing modal.


**example:**
```objective-c
    // Get Root View Controller
    UIViewController* myRootViewController = self.window.rootViewController;
    
    // Present sharing modal on myRootViewController
    [[Mighty sharedInstance] openFacebookShareModalFromViewController:myRootViewController withShareText:@"Share Text"];
```

---

