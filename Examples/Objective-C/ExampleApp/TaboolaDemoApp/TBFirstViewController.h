//
//  TBFirstViewController.h
//  TaboolaDemoApp


#import <UIKit/UIKit.h>
#import <TaboolaSDK/TaboolaView.h>

@interface TBFirstViewController : UIViewController <TaboolaViewDelegate>{
	IBOutlet TaboolaView *mTaboolaView;
	IBOutlet UIScrollView *mScrollView;
	IBOutlet UILabel *mTextLabel;
}

@end
