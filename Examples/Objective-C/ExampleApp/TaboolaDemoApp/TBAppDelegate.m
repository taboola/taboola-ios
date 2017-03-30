//
//  TBAppDelegate.m
//  TaboolaDemoApp


#import "TBAppDelegate.h"
#import "TBFirstViewController.h"
#import "TBSecondViewController.h"
#import "TBTestViewController.h"


@implementation TBAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //load viewcontrollers and tabbar
    TBFirstViewController *lFirstViewController = [[TBFirstViewController alloc] initWithNibName:@"TBFirstViewController" bundle:nil];
    UITabBarItem *lFirstTabBarItem = [[UITabBarItem alloc] initWithTitle:@"First" image:nil tag:0];
    UINavigationController *lFirstNavController = [[UINavigationController alloc] initWithRootViewController:lFirstViewController];
    lFirstNavController.navigationBarHidden = YES;
    lFirstNavController.tabBarItem = lFirstTabBarItem;
    
    TBSecondViewController *lSecondViewController = [[TBSecondViewController alloc] initWithNibName:@"TBSecondViewController" bundle:nil];
    UITabBarItem *lSecondTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Second" image:nil tag:1];
    
    TBTestViewController *testViewController = [[TBTestViewController alloc]initWithNibName:@"TBTestViewController" bundle:nil];
    UITabBarItem *testTabBarItem = [[UITabBarItem alloc] initWithTitle:@"Test" image:nil tag:2];
    UINavigationController *testNavController = [[UINavigationController alloc] initWithRootViewController:testViewController];
    testNavController.navigationBarHidden = YES;
    testNavController.tabBarItem = testTabBarItem;
    
    // Setting Tab bar font, color and v-alignnment
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"AmericanTypewriter" size:20.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blueColor], NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0.0, -5.0)];
  
    
    UINavigationController *lSecondNavController = [[UINavigationController alloc] initWithRootViewController:lSecondViewController];
    lSecondNavController.navigationBarHidden = YES;
    lSecondNavController.tabBarItem = lSecondTabBarItem;
    
    
    UITabBarController *lTabBarController = [[UITabBarController alloc] init];
    lTabBarController.viewControllers = [NSArray arrayWithObjects:lFirstNavController, lSecondNavController, testNavController, nil];
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
