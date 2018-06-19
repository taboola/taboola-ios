//
//  TBFirstViewController.m
//  TaboolaDemoApp


#import "TBWidgetViewController.h"

@implementation TBWidgetViewController

#pragma mark - Life cycle
- (void)viewDidLoad{
    [super viewDidLoad];

	//load tabolaView
	mTaboolaView.delegate = self;
    mTaboolaView.ownerViewController = self;
    mTaboolaView.mode = @"thumbnails-sdk1";
	mTaboolaView.publisher = @"betterbytheminute-app";
    mTaboolaView.pageType = @"article";
    mTaboolaView.pageUrl = @"http://www.example.com";
    mTaboolaView.placement = @"iOS Below Article Thumbnails";
	mTaboolaView.autoResizeHeight = YES;
    mTaboolaView.scrollEnable = NO;
    mTaboolaView.enableClickHandler = YES;
    mTaboolaView.logLevel = LogLevelDebug;

	NSDictionary *lPageDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/ref", @"referrer", nil];
    [mTaboolaView setOptionalPageCommands:lPageDictionary];

    NSDictionary *lModeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"mix", @"target_type", nil];
    [mTaboolaView setOptionalModeCommands:lModeDictionary];
	
    [mTaboolaView fetchContent];
}

#pragma mark - Rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

#pragma mark - UI
- (BOOL)prefersStatusBarHidden{
	return YES;
}

#pragma mark - Buttons methods
- (IBAction)refreshButtonPressed:(id)sender{
	[mTaboolaView refresh];
}

- (IBAction)resetButtonPressed:(id)sender{
	[mTaboolaView reset];
}

- (IBAction)loadAgainButtonPressed:(id)sender{
    mTaboolaView.pageType = @"article";
    mTaboolaView.pageUrl = @"www.lexpress.fr";
    mTaboolaView.placement = @"iOS Below Article Thumbnails";
    mTaboolaView.scrollEnable = NO;
    NSDictionary *lCommandsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/2/ref", @"referrer", nil];
    [mTaboolaView setOptionalPageCommands:lCommandsDictionary];
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

- (void)taboolaViewResizedToHeight:(CGFloat)height {
    
}

@end
