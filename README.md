MightyIO - iOS
=====================

[![CI Status](http://img.shields.io/travis/Gavin Potts/MightyIO-iOS-Pod.svg?style=flat)](https://travis-ci.org/Gavin Potts/MightyIO-iOS-Pod)
[![Version](https://img.shields.io/cocoapods/v/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![License](https://img.shields.io/cocoapods/l/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![Platform](https://img.shields.io/cocoapods/p/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
 

The Mighty will provide you with the methods you need to easily interface with the SuperMighty API.  It contains methods to log in, get mighty items, record purchases of mighty items, and prompt a user to share the purchase of a mighty item.

## Quick Start Guide
1. Add 'MightyIO' to your Podfile
2. Run Pod install (Refer to CocoaPod’s [Getting Started Guide](http://cocoapods.org/#getstarted) for detailed instructions.)
3. Import Mighty ``#import <MightyIO-iOS-Pod/Mighty.h>``
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

