MightyIO - iOS
=====================

[![CI Status](http://img.shields.io/travis/Gavin Potts/MightyIO-iOS-Pod.svg?style=flat)](https://travis-ci.org/Gavin Potts/MightyIO-iOS-Pod)
[![Version](https://img.shields.io/cocoapods/v/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![License](https://img.shields.io/cocoapods/l/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![Platform](https://img.shields.io/cocoapods/p/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
 

The MightyIO-iOS-Pod will provide you with the methods you need to easily interface with the SuperMighty API.  It contains methods to log in, place the SuperMighty Ribbon, and unlock items/features when a SuperMighty purchase is complete.

## Quick Start Guide
1. Add 'MightyIO-iOS-Pod' to your Podfile http://cocoapods.org/?q=mighty: ``pod 'MightyIO-iOS-Pod', '~> 0.7'``
2. Run Pod install (Refer to CocoaPod’s [Getting Started Guide](http://cocoapods.org/#getstarted) for detailed instructions.)
3. Import Mighty.h in your AppDelegate ``#import <MightyIO-iOS-Pod/Mighty.h>``
4. Add ``[Mighty initWithUsername:@"username" andPassword:@"password"];`` to - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions;
5. Place the Super Mighty Ribbon on your home screen using the code ``[[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 45) inViewController:self];`` or place the ribbon asset in your home screen as an UIButton and pass it to SuperMighty using ``[[Mighty sharedInstance] makeRibbonWithIBOutlet:smRibbonOutlet inViewController:self];``.
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

5. To verify that SuperMighty is running, run your app and a series of messages should log to the console indicating successful login and retrieval a Mighty Item for that game.
6. Place ribbon using the method ``[[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 45) inViewController:self];`` or ``[[Mighty sharedInstance] makeRibbonWithIBOutlet:smRibbonOutlet inViewController:self];``
7. Start testing.

Methods
-----
The Mighty contains public methods that will allow you to:

* Log in
* Process a Mighty Purchase
* Unlock the Mighty Item following a successful purchase

###Init Functions
**+ (Mighty*)sharedInstance;**
An class method that returns a shared instance of the Mighty.

**returns:**

* (Mighty*)sharedInstance - a shared instance of Mighty
___

**+ (Mighty*)initWithUsername:(NSString*)username andPassword:(NSString*)password;**  
An class method logs into the MightyIO. On login this method will return your game information based on bundleIdentifier as well as the Mighty Item associated with that game.

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
A method that will place the SuperMighty Ribbon at a specified center point.  Ribbon will only appear when a valid game and item has been created in your SuperMighty Account.  This method will also handle showing/hiding the ribbon based on campaign active state  when deployed to the app store.  While item is in development ribbon should always display when a valid item/game exists.

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

___

**- (void)makeRibbonWithIBOutlet:(UIButton*)button inViewController:(UIViewController*)viewController;**
This method allows you to manually place the SuperMighty ribbon asset in your view and then pass it to SuperMighty as an UIButton.  SuperMighty will then add a target to it which will launch SuperMighty on control event  UIControlEventTouchUpInside.  This method will also handle showing/hiding the ribbon based on campaign active state  when deployed to the app store.  While item is in development ribbon should always display when a valid item/game exists.

**params:**

* (UIButton*)button - The instance of the button you would like to launch SuperMighty
* (UIViewController*)viewController - The ViewController presenting the ribbon.

**example:**
```objective-c
    - (void)viewDidLoad
    {
        [[Mighty sharedInstance] makeRibbonWithIBOutlet:smRibbonOutlet inViewController:self];
    }
```

###Mighty Delegate Functions
The Mighty Delegate provides the methods required for your game to react to a purchase made through SuperMighty.  Typically this would involve unlocking them item or feature that the user has just payed for. 

To implement this:
1. Add the Mighty Delegate to your class:
``@interface HomeViewController : UIViewController <MightyDelegate>``
2. In your implementation add the method ``- (void)didRecordSuccessfulTransaction:(SKPaymentTransaction*)transaction;``  
3. Inside the didRecordSuccessfulTransaction method place your code to unlock your items.  Unlocking items dynamically is the best way to do this so that you can add new campaigns without resubmitting your app.