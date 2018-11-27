//
//  TBFirstViewController.m
//  TaboolaDemoApp


#import "TBWidgetViewController.h"

@implementation TBWidgetViewController

#pragma mark - Life cycle
- (void)viewDidLoad{
    [super viewDidLoad];

	//load tabolaView
	topTaboolaView.delegate = self;
    topTaboolaView.ownerViewController = self;
    topTaboolaView.mode = @"thumbnails-sdk1";
	topTaboolaView.publisher = @"betterbytheminute-app";
    topTaboolaView.pageType = @"article";
    topTaboolaView.pageUrl = @"http://www.example.com";
    topTaboolaView.placement = @"iOS Below Article Thumbnails";
    topTaboolaView.logLevel = LogLevelDebug;
	
    [topTaboolaView fetchContent];
    
    bottomTaboolaView.delegate = self;
    bottomTaboolaView.ownerViewController = self;
    bottomTaboolaView.mode = @"thumbnails-sdk3";
    bottomTaboolaView.publisher = @"betterbytheminute-app";
    bottomTaboolaView.pageType = @"article";
    bottomTaboolaView.pageUrl = @"http://www.example.com";
    bottomTaboolaView.placement = @"bottom";
    bottomTaboolaView.logLevel = LogLevelDebug;
    
    [bottomTaboolaView fetchContent];
}

#pragma mark - TaboolaView delegate
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic {
    NSLog(@"Start load request on first screen: %@ isOrganic? %@", clickUrl, organic ? @"YES":@"NO");
    if (organic) {
        NSLog(@"organic items should open as native app pages.");
    }
    return YES;
}

- (void)taboolaView:(UIView*)taboolaView didLoadPlacementNamed:(NSString *) placementName withHeight:(CGFloat)height {
    NSLog(@"Delegate: didReceiveAd event");
}

- (void)taboolaView:(UIView*) taboolaView didFailToLoadPlacementNamed:(NSString *) placementName withErrorMessage:(NSString *) error {
    NSLog(@"Delegate: didFailAd event");
}

-(void)taboolaView:(UIView *)taboolaView placementNamed:(NSString *)placementName resizedToHeight:(CGFloat)height {
    
}

@end
