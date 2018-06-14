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
    mTaboolaView.placement = @"feed";
    //mTaboolaView.targetType = @"mix";
	NSDictionary *lPageDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/2/ref", @"referrer", nil];
    [mTaboolaView setOptionalPageCommands:lPageDictionary];
    NSDictionary *lModeDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"mix", @"target_type", nil];
    [mTaboolaView setOptionalModeCommands:lModeDictionary];
    mTaboolaView.autoResizeHeight = YES;

	[mTaboolaView fetchContent];
	
	//show page content
	NSString *lPath = [[NSBundle mainBundle] bundlePath];
    NSString *lHTMLString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"page_2" ofType:@"html"] encoding:NSStringEncodingConversionAllowLossy error:nil];
    [mWebView loadHTMLString:lHTMLString baseURL:[NSURL fileURLWithPath:lPath]];
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
    mTaboolaView.pageUrl = @"http://www.example.com";
    mTaboolaView.placement = @"feed";
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
