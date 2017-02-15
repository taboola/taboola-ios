# Taboola iOS SDK
![Platform](https://img.shields.io/badge/Platform-iOS-green.svg)
[ ![Download](https://img.shields.io/badge/Download-1.4.0-blue.svg) ](https://github.com/taboola/taboola-ios)
[![License](https://img.shields.io/badge/License%20-Taboola%20SDK%20License-blue.svg)](https://www.taboola.com/)


## Table Of Contents
1. [Getting Started](#1-getting-started)
2. [Example App](#2-example-app)
3. [SDK Reference](#3-sdk-reference)


## 1. Getting Started

### 1.1 Minimum requirements

* Minimum iOS version: `6.0`

### 1.2 Incorporating the SDK

## Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Taboola in your projects.

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

### 1.3 Adding TaboolaView (Interface Builder)

To include Taboola in your app using Interface Builder: 
1. Add `UIView` to your ViewController.
`TaboolaView` subclasses `UIView` and behaves just like any other standard iOS view.
2. In the Identity Inspector set the custom class to `TaboolaView`;

![Alt text][inspector]

[inspector]: https://cloud.githubusercontent.com/assets/3852658/22969202/3d9d5fd2-f376-11e6-96de-f20f6e555839.png "Xcode: Identity Inspector"


#### 1.3.1 Adding TaboolaView in code

Import TaboolaView into your source files (or into your bridging header if you're using with Swift and not using frameworks with Cocoapods):

```objc
#import <TaboolaSDK/TaboolaView.h"
```
If you are using Swift and frameworks, then you can just import Taboola into your Swift source file:
```
import TaboolaSDK
```

#### 1.3.2 Using TaboolaView

```objc
TaboolaView* taboolaView = [[TaboolaView alloc] initWithFrame:<CGRect>];
taboolaView.delegate = self;
taboolaView.ownerViewController = self;
```

#### 1.3.3 Setting the TaboolaView properties

Optionally, you can set the TaboolaView attributes directly in code:

 ```objc
// Sets the widget UI mode (template)
taboolaView.mode = @"my-mode";
// Sets the publisher id
taboolaView.publisher = @"my-publisher";
// Sets the page type of the page on which the widget is displayed (one of article, photo, video, home, category, search)
taboolaView.pageType = @"article";
// Sets the canonical URL for the page on which the widget is displayed
taboolaView.pageUrl = @"http://www.example.com";
// Sets the widget placement code (for reporting /configuration purposes)
taboolaView.placement = @"Mobile";
// When enabled, TaboolaView automatically resizes its height after rendering the widget. Default YES.
taboolaView.autoResizeHeight = YES;
// Controls whether the widget content is scrollable or not (enabled by default)
taboolaView.scrollEnable = NO;
// Controls whether item clicks sent to the delegate clickHandler or not. if not they will be opened in Safari (default YES);
taboolaView.enableClickHandler = YES;
// Controls the ammount (level) of the console log messages by TaboolaSDK. LogLevel enum defines importance levels. Default: LogLevelError
taboolaView.logLevel = LogLevelDebug;
// After initializing the TaboolaView, this method should be called to actually fetch the recommendations
[taboolaView fetchContent];
```

#### 1.3.4 TaboolaViewDelegate
```
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic;
```
Attaches a delegate to the TaboolaView. Allows intercepting clicks.

**Return**: `YES` if the view should begin loading content; otherwise, `NO`. Default value is `YES`.

```
- (void)taboolaViewResizeHandler;
```
Triggered when the TaboolaView resizes after content render

```
- (void)taboolaDidReceiveAd:(UIView *)view;
```
Triggered after the TaboolaView is succesfully rendered

```
- (void)taboolaDidFailAd:(NSError *)error;
```
Triggered after the TaboolaView fails to render


### 1.4 Catching global notifications from TaboolaView (NSNotification)
TaboolaView sends notifications to notify all registered observers within the app about certain event. Catching those events might be useful for implementing custom event mediation adapters for ad platforms not natively supported by Taboola SDK.

Sending a click notification:
```
"taboolaItemDidClick"
```
Also sending a general notification in case the user wasn't able to add a delegate:
```
"taboolaViewResized"
```
```
"taboolaDidReceiveAd"
```
Sending a notification with NSError object:
```
"taboolaDidFailAd"
```

### 1.5 Intercepting recommendation clicks

The default click behavior of TaboolaView is as follows:

Depending on the iOS version TaboolaView opens the recommendation in one of the following browsers:
* In-App browser
* SafariViewController
* System browser - Safari

`TaboolaView` allows app developers to intercept recommendation clicks in order to create a click-through or to override the default way of opening the recommended article.

In order to intercept clicks, this protocol should be implemented by the host app. TaboolaView sends various lifecycle events to the delegate, to allow more flexibility for the host app. `@protocol TaboolaViewDelegate` includes the following delegate method:

 ```objc
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString:(BOOL)isOrganic;
 ```

##### 1.5.1 taboolaViewItemClickHandler

This method will be called every time user clicks a recommendation, right before triggering the default behavior. The app can intercept the click there, and should return a `BOOL` value.

* Return **`false`** - abort the default behavior, the app should display the recommendation content on its own (for example, using an in-app browser).
* Return **`true`** - this will allow the app to implement a click-through and continue to the default behaviour.

`isOrganic` indicates whether the item clicked was an organic content recommendation or not.
**Best practice would be to suppress the default behavior for organic items, and instead open the relevant screen in your app which shows that piece of content.**

##### 1.5.1.1 Example:
 ```objc
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString:(BOOL)isOrganic{
	NSLog(@"Start load request on first screen: %@ isOrganic? %@", pURLString, isOrganic ? @"YES":@"NO");
    if (isOrganic){
        NSLog(@"organic items should open as native app pages.");
    }
	return YES;
}
 ```

### 1.6. Handling Taboola widget resize

`TaboolaView` may resize its height after loading recommendations, to make sure that the full content is displayed (based on the actual widget `mode` loaded).

After resize, `TaboolaView` will call `taboolaViewResizeHandler` method of the `@protocol TaboolaViewDelegate`, to allow the host app to adjust its layout to the changes. (This behavior may be disabled by setting the property `autoResizeHeight` to `false`.)

## 2. Example App
This repository includes an example iOS app which uses the Taboola SDK. To use it, just clone this repository and open the project wih Xcode.

In case you encounter some issues when integrating the SDK into your app, try recreating the scenario within the example app. This might help isolate the problem, and in case you weren't able to solve it, you'll be able to send the example app with your recreated issue to Taboola's support for more help.

## 3. SDK Reference 
### 3.1. Public Properties

##### publisher

Mandatory. Sets the publisher id

##### mode

Mandatory. Sets the widget UI mode (template)

##### placement

Mandatory. Sets the page type of the page on which the widget is displayed (one of
article, photo, video, home, category, search)

##### pageType

Mandatory. Sets the canonical URL for the page on which the widget is displayed

##### pageUrl

Optional. the in-app browser will be pushed to thiw UIViewController

##### ownerViewController

Optional. Attaches a TaboolaViewDelegate to the TaboolaView. Allows intercepting clicks.

##### delegate

Optional. When enabled, TaboolaView automatically resizes its height after rendering the widget.Default YES.

##### autoResizeHeight

Default: true. Determines whether `TaboolaView` may resize when the loaded content requires

### 3.2. Public methods

Optional. Allows setting additional page commands to the Taboola widget, as used in the Taboola JavaScript API. @param pCommands list of commands.

##### -(void)setOptionalPageCommands:(NSDictionary *)pCommands;

Optional. Allows setting additional mode commands to the Taboola widget, as used in the Taboola JavaScript API. @param pCommands list of commands.

##### -(void)setOptionalModeCommands:(NSDictionary *)pCommands;

After initializing the TaboolaView, this method should be called to actually fetch the recommendations

##### - (void)fetchContent;

Resets the TaboolaView - All conents and pushed commands are cleared. new commands must be pushed before fetching data again.

##### - (void)reset;

Refreshes the recommendations displayed on the TaboolaView.

##### - (void)refresh;

Version of the SDK

##### + (NSString*)version;
