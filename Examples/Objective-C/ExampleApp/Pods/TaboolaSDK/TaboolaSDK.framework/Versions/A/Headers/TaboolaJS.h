//
//  TaboolaJS.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaboolaView.h"

@protocol TaboolaJSDelegate <NSObject>
@optional
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic;
- (void)webView:(UIView*) webView didLoadPlacementNamed:(NSString *) placementName withHeight:(CGFloat)height;
- (void)webView:(UIView*) webView didFailToLoadPlacementNamed:(NSString *) placementName withErrorMessage:(NSString *) error;
- (void)webView:(UIView*) webView didScrollToTop:(BOOL)top;
@end

@interface TaboolaJS : NSObject

/**
 TaboolaJSDelegate is used to intercept recommendation clicks, block default click handling for organic items and get notifications about render success or failure
 */
@property (nonatomic, weak) id<TaboolaJSDelegate> delegate;

/**
 @return a singleton instance of the SDK
 */
+ (instancetype) sharedInstance;

/**
 Registers webView within Taboola JS SDK. It is required to reload/load the page after registering the webview
 
 @param webView webview with HTML/JS widget
 */
- (void)registerWebView:(UIView*)webview withDelegate:(id<TaboolaJSDelegate>)delegate;
- (void)registerWebView:(UIView*) webView;

/**
 Unregisters an already registered webView from Taboola JS SDK. It is required to reload/load the page after unregistering the webview
 
 @param webView an already registered webView to unregister
 */
- (void)unregisterWebView:(UIView *)webview completion:(void(^)()) completion;

/**
 Set log level for the SDK. LogLevel enum defines importance levels. Default: LogLevelError.
 */
@property(nonatomic, readwrite) LogLevel logLevel;

/**
 Optional. the in-app browser will be pushed to thiw UIViewController
 */
@property(nonatomic, weak) UIViewController *ownerViewController;

/**
 Optional. Mediation provider.
 */
@property (nonatomic) NSString* mediation;


/**
 @return Set of all currently registered webViews
 */
- (NSSet*)registeredWebViews;

/**
 Use this method to set specific key-value pairs to adjust TaboolaJS behaviour
 
 @param properties dictionary with custom parameters for TaboolaJS
 */
- (void)setExtraPropetries:(NSDictionary*) properties;

/**
 Get all active extra properties
 */
- (NSDictionary *)extraProperties;

@end
