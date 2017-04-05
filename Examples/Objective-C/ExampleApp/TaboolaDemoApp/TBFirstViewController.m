//
//  TBFirstViewController.m
//  TaboolaDemoApp


#import "TBFirstViewController.h"

@implementation TBFirstViewController

#pragma mark - Life cycle
- (void)viewDidLoad{
    [super viewDidLoad];

	//load tabolaView
	mTaboolaView.delegate = self;
    mTaboolaView.ownerViewController = self;
    mTaboolaView.mode = @"thumbnails-h";
	mTaboolaView.publisher = @"lexpress-network";
    mTaboolaView.pageType = @"article";
    mTaboolaView.pageUrl = @"www.lexpress.fr";
    mTaboolaView.placement = @"iOS Below Article Thumbnails";
	mTaboolaView.autoResizeHeight = YES;
    mTaboolaView.scrollEnable = NO;
    mTaboolaView.enableClickHandler = YES;

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

#pragma mark - TaboolaView delegate
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic{
	NSLog(@"Start load request on first screen: %@ isOrganic? %@", pURLString, isOrganic ? @"YES":@"NO");
    if (isOrganic) {
        NSLog(@"organic items should open as native app pages.");
    }
	return YES;
}

- (void)taboolaDidReceiveAd:(UIView *)view{
    NSLog(@"Delegate: didReceiveAd event");
}

- (void)taboolaDidFailAd:(NSError *)error  {
    NSLog(@"Delegate: didFailAd event");
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

@end
