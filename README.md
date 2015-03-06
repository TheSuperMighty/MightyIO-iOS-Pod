MightyIO - iOS
=====================
[![Version](https://img.shields.io/cocoapods/v/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![License](https://img.shields.io/cocoapods/l/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)
[![Platform](https://img.shields.io/cocoapods/p/MightyIO-iOS-Pod.svg?style=flat)](http://cocoadocs.org/docsets/MightyIO-iOS-Pod)

The MightyIO-iOS-Pod will provide you with the methods you need to easily interface with the MightyIO.  It contains methods to log in, place the Mighty Ribbon, show/hide the ribbon, and unlock items/features when a Mighty purchase is complete.

## Quick Start Guide
-----

1. Before installing the MightIO into your iOS Game head over to http://themighty.io, signup, and create a promotion if you haven't already.
2. Install the Mighty to your project from cocopods at: http://cocoapods.org/?q=mighty
3. Import the Mighty to your project: `#import <MightyIO-iOS-Pod/Mighty.h>`
4. In your AppDelegate in the didFinishLaunchingWithOptions method instantiate the Mighty:
    
    ```objective-c
    - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
    {
        [Mighty initWithAuthToken:@"authtoken"];
        // Override point for customization after application launch.
        return YES;
    }
    ```
5. Place ribbon using the method ``[[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 45) inViewController:self withIntroModalOnFirstLaunch:YES];`` or ``[[Mighty sharedInstance] makeRibbonWithIBOutlet:smRibbonOutlet inViewController:self withIntroModalOnFirstLaunch:YES];``
6. In some cases you may want to show or hide the ribbon based on where your player is inside of your game.  This can be done very simply using the ``[[Mighty sharedInstance] makeRibbonHidden:NO withAnimation:YES];``  method.
7. Lastly make sure to add the Mighty delegate to your interface file.
8. The Mighty Delegate contains methods that will allow you to respond to a Mighty Purchase by unlocking the Mighty Item. 


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

**+ (Mighty*)initWithAuthToken:(NSString*)token**  
An class method logs into the MightyIO. On login this method will return your game information based on bundleIdentifier as well as the Mighty Item associated with that game.

**param:**

* (NSString*)token - SuperMighty Auth Token.  (Generated on sign up)

**example:**
```objective-c
    - (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
    {
        [Mighty initWithAuthToken:@"authtoken"];
        // Override point for customization after application launch.
        return YES;
    }
```
___

**- (void)makeRibbonWithFrame:(CGRect)frame inViewController:(UIViewController*)viewController withIntroModalOnFirstLaunch:(BOOL)modal;**
A method that will place the SuperMighty Ribbon at a specified center point.  Ribbon will only appear when a valid game and item has been created in your SuperMighty Account.  This method will also handle showing/hiding the ribbon based on campaign active state  when deployed to the app store.  While item is in development ribbon should always display when a valid item/game exists.

**params:**

* (CGPoint)center - The center point for placing the ribbon in the view.
* (UIViewController*)viewController - The ViewController presenting the ribbon.
* (BOOL)modal - Show the Mighty Info modal on first launch.  (This is recommended for best results)

**example:**
```objective-c
    - (void)viewDidLoad
    {
        [[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 45) inViewController:self withIntroModalOnFirstLaunch:YES];
    }
```

___

**- (void)makeRibbonWithIBOutlet:(UIButton*)button inViewController:(UIViewController*)viewController withIntroModalOnFirstLaunch:(BOOL)modal;**
This method allows you to manually place the SuperMighty ribbon asset in your view and then pass it to SuperMighty as an UIButton.  SuperMighty will then add a target to it which will launch SuperMighty on control event  UIControlEventTouchUpInside.  This method will also handle showing/hiding the ribbon based on campaign active state  when deployed to the app store.  While item is in development ribbon should always display when a valid item/game exists. It should be noted that this method will override the image property of your IBOutlet with the most current MightyIO branding

**params:**

* (UIButton*)button - The instance of the button you would like to launch SuperMighty
* (UIViewController*)viewController - The ViewController presenting the ribbon.
* (BOOL)modal - Show the Mighty Info modal on first launch.  (This is recommended for best results)

**example:**
```objective-c
    - (void)viewDidLoad
    {
        [[Mighty sharedInstance] makeRibbonWithIBOutlet:smRibbonOutlet inViewController:self withIntroModalOnFirstLaunch:YES];
    }
```
___

**- (void)makeRibbonHidden:(BOOL)hidden withAnimation:(BOOL)animate;**
Allows you to show or hide the ribbon based on where your player is inside of your game. 

**params:**

* (BOOL)hidden - Should the ribbon be hidden or not.
* (BOOL)animate - Should the ribbon transition be animated.

**example:**
```objective-c
    - (IBAction)showRibbon:(id)sender
{
    [[Mighty sharedInstance] makeRibbonHidden:NO withAnimation:YES];
}
```
___


###Mighty Delegate Functions
The Mighty Delegate provides the methods allow you to react to MightyIO actions inside your code such as: loading /opening/closing the pop-up shop and completing a purchase.

####Required

**- (void)mightyDidRecordSuccessfulTransaction:(SKPaymentTransaction*)transaction;**
When a player completes a purchase inside of the Mighty Pop-up Shop this delegate function is fired which returns an instance of the player transaction.  Place your code to unlock the item inside of this delegate method.

**params:**

* (SKPaymentTransaction*)transaction - Instance of the completed SKPaymentTransaction created by your player purchasing the MightyItem.

**example:**
```objective-c
- (void)mightyDidRecordSuccessfulTransaction:(SKPaymentTransaction*)transaction
{
    // You code to unlock the In-App Purchase
    // Ideally this would be dynamic so that a new deployment will not be necessary to create a new MightyItem
}
```
___

**- (void)mightyTransactionFailedWithError:(NSError*)error;**
This delegate method can be used to inform the player that their transaction was not able to be processed.

**params:**

* (NSError*)error - The error produced by the failed purchase.

**example:**
```objective-c
- (void)mightyTransactionFailedWithError:(NSError*)error
{
    UIAlertView *purchaseError = [[UIAlertView alloc] initWithTitle:@"Purchase Error" message:@"There was an error processing their purchase." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
        [purchaseError show];
}
```
___

**- (void)mightyFinishedLoadingWithActiveCampaign:(BOOL)hasCampaign;**
When your game loads the MightyIO runs a check to verify that the a MightyItem exists for a game matching your Bundle Identifier.  This delegate method is fired at this time.

**params:**

* (BOOL)hasCampaign - Returns true if a game and MightyItem matching the current bundle identifier exist.  Returns false if a game with the current bundle identifier is not found or if a MightyItem has not been set up yet.

___

**- (void)mightyModalOpen;**
This delegate method is triggered when a user clicks on the ribbon and opens the Mighty Pop-up Shop.

**example:**
```objective-c
- (void)mightyModalOpen
{
    //Pause game play
}
```

___

**- (void)mightyModalOpen;**
This delegate method is triggered when a player closes the Mighty Pop-up Shop.

**example:**
```objective-c
- (void)mightyModalClosed
{
    //Resume game play
}
```

___


> Written with [StackEdit](https://stackedit.io/).