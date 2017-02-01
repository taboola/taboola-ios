//
//  TBSecondViewController.m
//  TaboolaDemoApp


#import "TBSecondViewController.h"

#define BOTTOM_MARGIN 5.f
#define HEADER_LENGTH 42.0f

@implementation TBSecondViewController

#pragma mark - Life cycle
- (void)viewDidLoad{
    [super viewDidLoad];
	
	//load tabolaView
	mTaboolaView.delegate = self;
    mTaboolaView.ownerViewController = self;
    mTaboolaView.mode = @"alternating-thumbnails-a";
    mTaboolaView.publisher = @"betterbytheminute";
    mTaboolaView.pageType = @"article";
    mTaboolaView.pageUrl = @"http://www.example.com/2";
    mTaboolaView.placement = @"Mobile";
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

- (void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    
    //show page content
	NSMutableAttributedString * lText = [[NSMutableAttributedString alloc] initWithString:@"Interdum et malesuada fames ac ante ipsum! \n\nCum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aliquam lacus lorem, tristique vel molestie sed, laoreet in felis. Pellentesque consectetur massa libero, in bibendum nisl euismod ultricies. Vestibulum eros neque, venenatis id luctus id, ornare eu lorem. Duis elementum neque ut erat elementum fermentum eget eget libero. Duis nisl odio, bibendum vel lobortis eget, accumsan vitae urna. Aenean mauris leo, convallis nec porta in, auctor at dui. In a diam sit amet orci facilisis feugiat a tristique urna. Duis vitae malesuada tellus."];
	[lText addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldMT" size:22] range:NSMakeRange(0, HEADER_LENGTH)];
	[mTextLabel setAttributedText:lText];
    
    [mTextLabel sizeToFit];
	
	[mScrollView setContentSize:CGSizeMake(mScrollView.frame.size.width, mTextLabel.frame.size.height + mTaboolaView.frame.size.height + BOTTOM_MARGIN)];
	[mTaboolaView setCenter:CGPointMake(mScrollView.frame.size.width/2, mScrollView.contentSize.height - mTaboolaView.frame.size.height/2)];
}

#pragma mark - Rotation
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[mScrollView setContentSize:CGSizeMake(mScrollView.frame.size.width, mTextLabel.frame.size.height + mTaboolaView.frame.size.height + BOTTOM_MARGIN)];
	[mTaboolaView setCenter:CGPointMake(mScrollView.frame.size.width/2, mScrollView.contentSize.height - mTaboolaView.frame.size.height/2)];
}

#pragma mark - TaboolaView delegate
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic{
	NSLog(@"Start load request on first screen: %@ isOrganic? %@", pURLString, isOrganic ? @"YES":@"NO");
    if (isOrganic) {
        NSLog(@"organic items should open as native app pages.");
    }
	return YES;
}

- (void)taboolaViewResizeHandler{
	[mScrollView setContentSize:CGSizeMake(mScrollView.frame.size.width, mTextLabel.frame.size.height + mTaboolaView.frame.size.height + BOTTOM_MARGIN)];
	[mTaboolaView setCenter:CGPointMake(mScrollView.frame.size.width/2, CGRectGetMaxY(mTextLabel.frame) + mTaboolaView.frame.size.height/2)];
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
    mTaboolaView.pageUrl = @"http://www.example.com/2";
    mTaboolaView.placement = @"mobile";
    mTaboolaView.scrollEnable=NO;
    NSDictionary *lCommandsDictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"http://www.example.com/2/ref", @"referrer", nil];
    [mTaboolaView setOptionalPageCommands:lCommandsDictionary];
    [mTaboolaView fetchContent];
}

@end
