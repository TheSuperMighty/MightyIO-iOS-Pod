MightyIO - iOS
=====================

[![CI Status](http://img.shields.io/travis/Gavin Potts/MightyIO-iOS-Pod.svg?style=flat)](https://travis-ci.org/Gavin Potts/MightyIO-iOS-Pod)
[![Version](https://img.shields.io/cocoapods/v/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![License](https://img.shields.io/cocoapods/l/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![Platform](https://img.shields.io/cocoapods/p/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
 

The MightyIO will provide you with the methods you need to easily interface with the SuperMighty API.  It contains methods to log in, place the SuperMighty Ribbon, and unlock items/features when a SuperMighty purchase is complete.

## Quick Start Guide
1. Add 'MightyIO-iOS-Pod' to your Podfile 
2. Run Pod install (Refer to CocoaPod’s [Getting Started Guide](http://cocoapods.org/#getstarted) for detailed instructions.)
3. Import Mighty.h in your AppDelegate ``#import <MightyIO-iOS-Pod/Mighty.h>``
4. Add ``[Mighty initWithUsername:@"username" andPassword:@"password"];`` to - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions;
5. Place the Super Mighty Ribbon on your desired screen using the code ``[[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 45) inViewController:self];``
6. Add the Mighty Delegate to your view controller: ``@interface HomeViewController : UIViewController <MightyDelegate>``
7. In your ViewController add ``[Mighty sharedInstance].mightyDelegate = self;`` to -(void)viewDidLoad;
8. Add the SuperMighty callback function to your ViewController ``- (void)didRecordSuccessfulTransaction:(SKPaymentTransaction*)transaction;``
9. Inside the didRecordSuccessfulTransaction function place the code to unlock your item.


Installation
-----
1. Install the Mighty to your project from cocopods at: http://cocoapods.org/?q=mighty
2. Import the Mighty to your project: `#import <MightyIO-iOS-Pod/Mighty.h>`
3. Before instantiating Mighty you must first register at http://themighty.io
* Create an account.
* Add a game
* Add an item to your game and set it to be the test item.
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
6. Place ribbon using the method ``[[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 45) inViewController:self];``
7. Start testing.

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
___

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
___

**- (void)makeRibbonWithCenter:(CGPoint)center inViewController:(UIViewController*)viewController;**
A method that will place the SuperMighty Ribbon on a specified ribbon.  Ribbon will only appear when a valid game and item has been created in your SuperMighty Account.  This method will also handle showing/hiding the ribbon based on campaign active states  when deployed to the app store.  While item is in development ribbon should always display when a valid item/game exists.

**params:**

* (CGPoint)center - The center point for placing the ribbon in the view.
* (UIViewController*)viewController - The ViewController presenting the ribbon.

**example:**
```objective-c
    - (void)viewDidLoad
    {
        [[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 45) inViewController:self];
    }
```

###Mighty Delegate Functions
The Mighty Delegate provides the methods required for your game to react to a purchase made through SuperMighty.  Typically this would involve unlocking them item or feature that the user has just payed for. 

To implement this:
1. Add the Mighty Delegate to your class:
``@interface HomeViewController : UIViewController <MightyDelegate>``
2. In your implementation add the method ``- (void)didRecordSuccessfulTransaction:(SKPaymentTransaction*)transaction;``
3. Inside the didRecordSuccessfulTransaction method place your code to unlock your items.  Unlocking items dynamically is the best way to do this so that you can add new campaigns without resubmitting your app.