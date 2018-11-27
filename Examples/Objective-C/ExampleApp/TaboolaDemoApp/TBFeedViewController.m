//
//  TBSecondViewController.m
//  TaboolaDemoApp


#import "TBFeedViewController.h"

@implementation TBFeedViewController

#pragma mark - Life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
	
	//load tabolaView
	mTaboolaView.delegate = self;
    mTaboolaView.ownerViewController = self;
    mTaboolaView.mode = @"thumbnails-feed";
    mTaboolaView.publisher = @"betterbytheminute-app";
    mTaboolaView.pageType = @"article";
    mTaboolaView.pageUrl = @"http://www.example.com";
    mTaboolaView.placement = @"feed-sample-app";
    mTaboolaView.targetType = @"mix";
    [mTaboolaView setInterceptScroll:YES];
	[mTaboolaView fetchContent];

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
