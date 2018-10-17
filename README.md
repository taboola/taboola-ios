# Taboola iOS SDK
![Platform](https://img.shields.io/badge/Platform-iOS-green.svg)
[![Version](https://img.shields.io/cocoapods/v/TaboolaSDK.svg?label=Version)](https://github.com/taboola/taboola-ios)
[![License](https://img.shields.io/badge/License%20-Taboola%20SDK%20License-blue.svg)](https://github.com/taboola/taboola-ios/blob/master/LICENSE)

> **NOTICE**: As of version 1.5.1, clicks on non-organic items will be handled by Taboola SDK and the app will not be allowed to override the default click handler. "No" responses from `taboolaViewItemClickHandler` will only be honored for organic items.


## Table Of Contents
1. [Getting Started](#1-getting-started)
2. [Example App](#2-example-app)
3. [Mediation](#3-mediation)
4. [SDK Reference](#4-sdk-reference)
5. [GDPR](#5-gdpr)
6. [License](#6-license)


## 1. Getting Started

### 1.1 Minimum requirements

* Build against Base SDK `7.0` or later. Deployment target: iOS `6.0` or later.
* Use `Xcode 5` or later.

### 1.2 Incorporating the SDK

## Installation

[Installation with CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Taboola in your projects.

You can install it with the following command:

```bash
$ gem install cocoapods
```

#### Podfile

To integrate Taboola into your Xcode project using CocoaPods, specify it in your `Podfile`:
* Objective-C
```ruby
pod 'TaboolaSDK'
```

* Swift
```ruby
use_frameworks!
pod 'TaboolaSDK'
```

Then, run the following command:

```bash
$ pod install
``` 
[Installation with Carthage]**[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks thus requires deployment target of minimum iOS 8.0**

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Taboola into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
binary "https://cdn.taboola.com/taboola-mobile-sdk/ios/carthage/Carthage.json" ~> 2.0.30
```

Run `carthage update` to build the framework and drag the built `TaboolaFramework.framework` into your Xcode project.

### 1.3 Including Taboola recommendations in your app

#### 1.3.1 Adding TaboolaView in Interface Builder

To include Taboola in your app using Interface Builder: 
1. Add `UIView` to your ViewController.
`TaboolaView` subclasses `UIView` and behaves just like any other standard iOS view.
2. In the Identity Inspector set the custom class to `TaboolaView`;

![Alt text][inspector]

[inspector]: https://cloud.githubusercontent.com/assets/3852658/22969202/3d9d5fd2-f376-11e6-96de-f20f6e555839.png "Xcode: Identity Inspector"


#### 1.3.2 Adding TaboolaView in code

Import TaboolaView into your source files (or into your bridging header if you're using with Swift and not using frameworks with Cocoapods):

```objc
#import <TaboolaSDK/TaboolaView.h>
```
If you are using Swift and frameworks, then you can just import Taboola into your Swift source file:
```
import TaboolaSDK
```
If you're using Cathage for Taboola integration, import the framework:
```
#import <TaboolaViewFramework/TaboolaView.h>
```

#### 1.3.3 Using TaboolaView

```objc
TaboolaView* taboolaView = [[TaboolaView alloc] initWithFrame:<CGRect>];
taboolaView.delegate = self;
taboolaView.ownerViewController = self;
```

#### 1.3.4 Setting the TaboolaView properties

Get the following parameters from your Taboola account manager: 

```objc
// An identification of a Taboola recommendation unit UI template (you might use different UI templates in different parts of the app, in which case you will need to get the applicable mode for each UI template) 
taboolaView.mode = @"my-mode";
```
```objc
// An identification of your publisher account on the Taboola system 
taboolaView.publisher = @"my-publisher";
```
```objc
// Sets the page type of the page on which the widget is displayed (one of article, photo, video, home, category, search)
taboolaView.pageType = @"my-page-type";
```
```objc
// Sets the canonical URL for the page on which the widget is displayed
taboolaView.pageUrl = @"my-page-url";
```
```objc
// An identification of a specific placement in the app (you might place Taboola recommendation units in multiple placements in the app, in which case you should get applicable placement ids for each such placement) 
taboolaView.placement = @"my-placement";
```
```objc
// After initializing the TaboolaView, this method should be called to actually fetch the recommendations
[taboolaView fetchContent];
```

#### 1.3.5 Code example 
A code similar to this should be added to your ViewController viewDidLoad method:

```objc
- (void)viewDidLoad{
	[super viewDidLoad];

	// Load taboolaView
	taboolaView.delegate = self;
	taboolaView.ownerViewController = self;
	taboolaView.mode = @"my-mode";
	taboolaView.publisher = @"my-publisher";
	taboolaView.pageType = @"article";
	taboolaView.pageUrl = @"http://www.example.com";
	taboolaView.placement = @"Mobile";
	taboolaView.targetType = @"mix";

	// Optional - add more page commands if needed 
	NSDictionary *lPageDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/ref", 	@"referrer", nil];
	[taboolaView setOptionalPageCommands:lPageDictionary];

	// Fill taboolaView with recommendations 
	[taboolaView fetchContent];
}

```

### 1.4 TaboolaViewDelegate

```objc
// Optionally set the TaboolaViewDelegate, to listen to taboolaView events and clicks
taboolaView.delegate = self;
```

#### 1.4.1 Intercepting recommendation clicks

```objc
// To intercept recommendation clicks
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic
```

**Return**: `YES` if the taboolaView should handle the click; otherwise, `NO`. Default value is `YES`. 
> **NOTICE**: As of version 1.5.1, clicks on non-organic items will be handled by Taboola SDK and the app will not be allowed to override the default click handler. "No" responses from `taboolaViewItemClickHandler` will only be honored for organic items.

This method will be called every time a user clicks a recommendation, right before triggering the default behavior.
If recommendation clicks are not intercepted, they will be presented by a Taboola powered in-app browser. Also important to note that TaboolaView also fires notifications that can be caught by any object inside the app, in case you want to react to these notifications elsewhere in your code. 

The app can intercept the click there, and should return a boolean value:

* Returns NO - abort the default behavior (in which case the app should display the recommendation content on its own - e.g. using a custom in-app browser). 
* Returns YES - this will allow the app to implement a click-through and continue with the default click handling behavior (which will display the clicked content with an in-app browser). 

`organic ` indicates whether the item clicked was an organic content recommendation or not.
**Best practice would be to suppress the default behavior for organic items, and instead open the relevant screen in your app which shows that piece of content.**

Use `itemId` in organic clicks for deeplink.

`clickUrl` is the url with the redirect.

#### 1.4.2 Example:
```objc
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic {
	NSLog(@"Start load request on first screen: %@ isOrganic? %@", clickUrl, organic ? @"YES":@"NO");
    if (organic) {
        NSLog(@"organic items should open as native app pages.");
    }
    return YES;
}
```
#### 1.4.3 Loading delegate fuctions:

```objc
// Triggered after the TaboolaView is succesfully rendered
- (void)taboolaView:(UIView *)taboolaView didLoadPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height;
```
```objc
// Triggered after the TaboolaView fails to render
- (void)taboolaView:(UIView *)taboolaView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error;
```
```objc
// Triggered when the TaboolaView resizes after content render or orientation change.
- (void)taboolaViewResizedToHeight:(CGFloat)height;
```

### 1.5. How to set TaboolaView height and scroll:
#### 1.5.1 For widget:
* Choose between fixed or automatic height

#### Automatic height resize
By default, TaboolaView automatically adjusts its own height in run time to show the entire widget. 

The SDK will automatically decide the height, so you don’t need to give it.

```objc
taboolaView.autoResizeHeight = YES; // This is the default, no need to add this code
```

```objc
//Disable scroll inside the widget
taboolaView.scrollEnable = NO;//This is the default, no need to add this code
```

####  Fixed height:

```objc
Set the TaboolaView frame (The most important is the height).
```
```objc
taboolaView.autoResizeHeight = NO;
```
```objc
//Enable scroll inside the widget
taboolaView.scrollEnable = YES;
```

#### 1.5.2 For Feed:
Our widget is a custom webview. The feed is endless and it has a scroll functionality.
When implementing feed, the view has a fixed size, usually in the bottom of the screen. When the app is scrolled and the view is taking up all the screen, the app scroll should hand over the scroll to our view (inner scroll of the webview).


```objc
// To enable scroll switch between the scrollView and taboolaView
[taboolaView setInterceptScroll:YES];
```
#### Automatic height
By default, TaboolaView automatically adjusts its own height in run time to show the entire widget. 

```objc
//To get the automatic height
TaboolaView.widgetHeight;
```
In collectionView or tabolaView, set your cell height with ```TaboolaView.widgetHeight;```

```objc
taboolaView.autoResizeHeight = YES; // This is the default, no need to add this code
```

```objc
//Disable scroll inside the widget
taboolaView.scrollEnable = NO;//This is the default, no need to add this code
```
####  Fixed height:

```objc
Set the TaboolaView frame (The most important is the height).
In CollectionView or tableView, set the cell height the same to tabolaView.
```
```objc
taboolaView.autoResizeHeight = NO;
```
```objc
//Enable scroll inside the widget
taboolaView.scrollEnable = YES;
```

### 1.7. Replacing the default in-app browser icons
The file TaboolaViewResources.bundle includes the default icons for the TaboolaView in-app browser. These icons can be replaced by providing an alternative TaboolaViewResources.bundle file which contains the following files: 
* back_icon.png
* forward_icon.png

### 1.8. IDFA Reporting
If the user chose to allow IDFA sharing with the host app, the IDFA is sent to the Taboola server as a page command with the key “device”

### 1.9. NSNotificationCenter notifications

The taboolaView widget also reports its status to the host app via `NSNotificationCenter` notifications (in addition to calling the TaboolaViewDelegate methods). This allows the host app to be more loosely coupled with the taboolaView. All notifications include a reference to the taboolaView itself. Here’s the list of notifications sent:
* taboolaDidReceiveAd - When the widget successfully loads its content.
* taboolaViewResized - When the taboolaView changes its height to adapt to its content. The notification data includes the new height. 
* taboolaItemDidClick - When the user clicks an item on the taboolaView.
* taboolaDidFailAd - When the taboolaView fails to load its content. The error is included in the notification data. 

## 2. Example App
This repository includes an example iOS app which uses the Taboola SDK, [here](https://github.com/taboola/taboola-ios/tree/master/Examples) . To use it, just clone this repository and open the project wih Xcode.

In case you encounter some issues when integrating the SDK into your app, try to recreate the scenario within the example app. This might help to isolate the problem, and in case you weren't able to solve it, you'll be able to send the example app with your recreated issue to Taboola's support for more help.

## 3. Mediation

### 3.1 Supported Ad Platforms

Taboola iOS SDK supports mediation via these platforms:

* [DFP](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/custom-events)
* [MoPub](http://www.mopub.com/resources/docs/ios-sdk-integration/ios-getting-started)
### 3.2 Setup of DFP mediation
In order to configure mediation of Taboola SDK, via DFP follow the steps listed below:
##### 3.2.1 Add DFP Framework to your project 
[Get Started with DFP](https://developers.google.com/mobile-ads-sdk/docs/dfp/ios/quick-start)

##### 3.2.2 Add protocol `<GADBannerViewDelegate>` in your ViewController
```objc
@interface TBViewControllerDfp () <GADBannerViewDelegate> {
GADBannerView *dfpBannerView;
}
```

##### 3.2.3 Follow the sample code to create a GADBannerView in `viewDidLoad` using `Objective-C`:
```objc
// Define custom GADAdSize of 480x320 for GADBannerView.
GADAdSize customAdSize = GADAdSizeFromCGSize(CGSizeMake(480, 320));
CGPoint point = CGPointMake(0, 40);
dfpBannerView = [[GADBannerView alloc] initWithAdSize:customAdSize origin:point];
[self.view addSubview:dfpBannerView];
dfpBannerView.delegate = self;
dfpBannerView.adUnitID = @"your-unit-id";
dfpBannerView.rootViewController = self;
```
```objc
- (void)viewDidAppear:(BOOL)animated {
[dfpBannerView loadRequest:[GADRequest request]];
}
```
##### 3.2.4 Follow the sample code to create a GADBannerView in `viewDidLoad` using `Swift`:

```objc
// Define custom GADAdSize of 480x320 for GADBannerView.
let customAdSize = GADAdSizeFromCGSize(CGSize(width: 480, height: 320))
let point = CGPoint(x: 0, y: 40)
let dfpBannerView = GADBannerView(adSize: customAdSize, origin: point)
view.addSubview(dfpBannerView)
dfpBannerView.delegate = self
dfpBannerView.adUnitID = "your_unit_id"
dfpBannerView.rootViewController = self
dfpBannerView.load(GADRequest())
```

##### 3.2.5 Add Adapter files into your project (available on [GitHub](https://github.com/taboola/taboola-ios)):

* `DfpTaboolaEventBanner.h`
* `DfpTaboolaEventBanner.m`
##### 3.2.6 Configure DFP
* **Class name**: `DfpTaboolaEventBanner`
* **Parameters**: Parameters for the Taboola SDK can be configured from the DFP web interface.
* 	**Configuring from DFP web interface**: The "parameter" field in the DFP custom event configuration screen, should contain a JSON string with the required properties. Notice that strings should be enclosed within ***escaped double quotes***.

```javascript
{
\"publisher\":\"<publisher code>\",
\"mode\":\"<mode>\",
\"url\":\"<url>\",
\"placement\":\"<placement>\",
\"article\":\"<article>\",
\"referrer\":\"<ref url>"
}
```
### 3.3 Setup of MoPub mediation
In order to configure mediation of Taboola SDK, via MoPub follow the steps listed below:
##### 3.3.1 Add MoPub Framework to your project 
[Get Started with MoPub](http://www.mopub.com/resources/docs/ios-sdk-integration/ios-getting-started/)

##### 3.3.2 Add protocol `<MPAdViewDelegate>` in your ViewController
```objc
@interface TBViewControllerMopub () <MPAdViewDelegate> {
MPAdView *moPubView;
}
```
##### 3.3.3 Follow the sample code to create a MPAdView in `viewDidLoad` using `Objective-C`:
```objc
moPubView = [[MPAdView alloc]initWithAdUnitId:@"your-unit-id" size:MOPUB_MEDIUM_RECT_SIZE];
moPubView.delegate = self;
CGPoint framePosition = CGPointMake(CGRectGetMidX(self.view.bounds) - (MOPUB_MEDIUM_RECT_SIZE.width/2), 40);
moPubView.frame = CGRectMake(framePosition.x, framePosition.y, MOPUB_MEDIUM_RECT_SIZE.width, MOPUB_MEDIUM_RECT_SIZE.height);
[self.view addSubview:moPubView];
[moPubView loadAd];
[super viewDidLoad];
```
```objc
- (UIViewController *)viewControllerForPresentingModalView {
return self;
}
```
##### 3.3.4 Follow the sample code to create a MPAdView in `viewDidLoad` using `Swift`:

```objc
moPubView = MPAdView(adUnitId: "your-unit-id", size: MOPUB_MEDIUM_RECT_SIZE)
moPubView.delegate = self
var framePosition = CGPoint(x: CGFloat(self.view.bounds.midX - (MOPUB_MEDIUM_RECT_SIZE.width / 2)), y: CGFloat(40))
moPubView.frame = CGRect(x: CGFloat(framePosition.x), y: CGFloat(framePosition.y), width: CGFloat(MOPUB_MEDIUM_RECT_SIZE.width), height: CGFloat(MOPUB_MEDIUM_RECT_SIZE.height))
self.view.addSubview(moPubView)
moPubView.loadAd()
super.viewDidLoad()
```

##### 3.3.5 Add Adapter files into your project (available on [GitHub](https://github.com/taboola/taboola-ios)):
* `MoPubCustomEventBanner.h`
* `MoPubCustomEventBanner.m`
##### 3.3.6 Configure MoPub
* **Class name**: `MoPubCustomEventBanner`
* **Parameters**: Parameters for the Taboola SDK can be configured from the MoPub web interface.
* 	**Configuring from DFP web interface**: The "parameter" field in the MoPub custom event configuration screen, should contain a JSON string with the required properties. Notice that strings should be enclosed within ***double quotes***.

```javascript
{
"publisher":"<publisher code>",
"mode":"<mode>",
"url":"<url>",
"article":"<article>",
"placement":"<placement>",
"referrer":"<http://www.example.com/ref>"
}
```

## 4. SDK Reference 
### 4.1. Public Properties

```objc
// Mandatory. Sets the publisher id
@property(nonatomic, strong) NSString *publisher 
```

```objc
// Mandatory. Sets the widget UI mode (template) 
@property(nonatomic, strong) NSString *mode  
```

```objc
// Mandatory. Sets the widget placement code (for reporting /; configuration purposes)  
@property(nonatomic, strong) NSString *placement   
```

```objc
// Mandatory. Sets the canonical URL for the page on which the widget is displayed  
@property(nonatomic, strong) NSString *pageUrl    
```

```objc
// Optional. Sets the page id of the page on which the widget is displayed (default to auto generate from the URL)  
@property(nonatomic, strong) NSString *pageId     
```

```objc
// Optional. Attaches a TaboolaViewDelegate to the TaboolaView. Allows intercepting clicks.  
@property(nonatomic, weak) id<TaboolaViewDelegate> delegate      
```

```objc
// Optional. Taboola in-app web-browser will be used to present selected content if this viewController is provided. If not provided, clicks will be opened in Safari.   
@property(nonatomic, weak) UIViewController *ownerViewController     
```

```objc
// Optional. controls whether to show or hide the action buttons on the in-app browser. Default YES 
@property(nonatomic, readwrite) BOOL showBrowserIcons 
```

```objc
// Optional. sets the background color for the in-app browser. Default #f5f6f4  
@property (nonatomic, strong) UIColor *browserBackColor  
```

```objc
// Optional. Sets the color for the in-app browser title text. Default #007cff   
@property (nonatomic, strong) UIColor *browserTitleTextColor   
```

```objc
// Optional. when enabled, TaboolaView automatically resizes its height after rendering the widget, Default YES    
@property(nonatomic, readwrite) BOOL autoResizeHeight    
```
```objc
// Optional. Mediation provider.    
@property (nonatomic) NSString* mediation    
```

```objc
// Optional. default: false. When set to true, forces TaboolaView to use UIWebView as the widget container instead of WKWebView even when WKWebView is available (iOS 8 and above). Please consult Taboola support or your Taboola account manager before using this feature.
@property(nonatomic, readwrite) BOOL forceLegacyWebView
```

### 4.2. Public methods

Optional. Allows setting additional page commands to the Taboola widget, as used in the Taboola JavaScript API. @param pCommands list of commands.

```objc
- (void)setOptionalPageCommands:(NSDictionary *)pCommands;
```

Optional. Allows setting additional mode commands to the Taboola widget, as used in the Taboola JavaScript API. @param pCommands list of commands.

```objc
- (void)setOptionalModeCommands:(NSDictionary *)pCommands;
```

After initializing the TaboolaView, this method should be called to actually fetch the recommendations

```objc
- (void)fetchContent;
```

Resets the TaboolaView - All conents and pushed commands are cleared. new commands must be pushed before fetching data again.

```objc
- (void)reset;
```

Refreshes the recommendations displayed on the TaboolaView.

```objc
- (void)refresh;
```
## 5. GDPR

In order to support the The EU General Data Protection Regulation (GDPR - https://www.eugdpr.org/) in Taboola Mobile SDK,capplication developer should show a pop up asking the user's permission for storing their personal data in the App. In order to control the user's personal data(to store in the App or not) there exists a flag `User_opt_out`. It's mandatory to set this flag when using the Taboola SDK. The way to set this flag depends on the type of SDK you are using. By default we assume no permission from the user on a pop up, so the personal data will not be saved.


### 5.1. How to set the flag in the SDK integration

Below you can find the way how to set the flag on iOS SDK Standard we support.
It's recommended to put these lines alongside the other settings, such as publisher name, etc

```javascript
//load taboolaView
mTaboolaView.delegate = self;
mTaboolaView.ownerViewController = self;
mTaboolaView.mode = @"thumbnails-a";
mTaboolaView.publisher = @"the-publisher-name";
mTaboolaView.pageType = @"article";
mTaboolaView.pageUrl = @"http://www.example.com";
mTaboolaView.placement = @"Mobile second";
 //mTaboolaView.targetType = @"mix";
 [mTaboolaView setOptionalPageCommands:@{@"user_opt_out":@"true"}];

 ```


## 6. License

This program is licensed under the Taboola, Inc. SDK License Agreement (the “License Agreement”).  By copying, using or redistributing this program, you agree with the terms of the License Agreement.  The full text of the license agreement can be found at https://github.com/taboola/taboola-ios/blob/master/LICENSE.
Copyright 2017 Taboola, Inc.  All rights reserved.
