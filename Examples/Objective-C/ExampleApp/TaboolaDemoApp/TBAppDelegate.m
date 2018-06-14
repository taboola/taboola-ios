//
//  TBAppDelegate.m
//  TaboolaDemoApp


#import "TBAppDelegate.h"
#import "TBWidgetViewController.h"
#import "TBFeedViewController.h"
#import "TBTestViewController.h"
#import "TBFeedCollectionView.h"

@implementation TBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //load viewcontrollers and tabbar
    TBWidgetViewController *widgetViewController = [[TBWidgetViewController alloc] initWithNibName:@"TBWidgetViewController" bundle:nil];
    UITabBarItem *widgetTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Widget" image:nil tag:0];
    UINavigationController *widgetNavController = [[UINavigationController alloc] initWithRootViewController:widgetViewController];
    widgetNavController.navigationBarHidden = YES;
    widgetNavController.tabBarItem = widgetTabBarItem;
    
    TBFeedViewController *feedScrollViewController = [[TBFeedViewController alloc] initWithNibName:@"TBFeedViewController" bundle:nil];
    UITabBarItem *feedScrollTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Feed ScrollView" image:nil tag:1];
    UINavigationController *feedScrollNavController = [[UINavigationController alloc] initWithRootViewController:feedScrollViewController];
    feedScrollNavController.navigationBarHidden = YES;
    feedScrollNavController.tabBarItem = feedScrollTabBarItem;
    
    TBFeedCollectionView *feedCollectionView = [[TBFeedCollectionView alloc]initWithNibName:@"TBFeedCollectionView" bundle:nil];
    UITabBarItem *feedCollectionTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Feed collectionView" image:nil tag:2];
    UINavigationController *feedCollectionNavController = [[UINavigationController alloc] initWithRootViewController:feedCollectionView];
    feedCollectionNavController.navigationBarHidden = YES;
    feedCollectionNavController.tabBarItem = feedCollectionTabBarItem;
    
    // Setting Tab bar font, color and v-alignnment
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AmericanTypewriter" size:15.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -5.0)];
    
    
    UITabBarController *lTabBarController = [[UITabBarController alloc] init];
    lTabBarController.viewControllers = [NSArray arrayWithObjects:widgetNavController, feedScrollNavController, feedCollectionNavController, nil];
    lTabBarController.selectedIndex = 0;
    self.window.rootViewController = lTabBarController;
    
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
