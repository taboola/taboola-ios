//
//  TBSecondViewController.h
//  TaboolaDemoApp


#import <UIKit/UIKit.h>
#import <TaboolaSDK/TaboolaView.h>

@interface TBFeedViewController : UIViewController <TaboolaViewDelegate>{
	IBOutlet TaboolaView *mTaboolaView;
	IBOutlet UIScrollView *mScrollView;
	IBOutlet UILabel *mTextLabel;
}

@end
