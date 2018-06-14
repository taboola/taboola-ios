//
//  TBFirstViewController.h
//  TaboolaDemoApp


#import <UIKit/UIKit.h>
#import <TaboolaSDK/TaboolaView.h>

@interface TBWidgetViewController : UIViewController <TaboolaViewDelegate>{
	IBOutlet TaboolaView *mTaboolaView;
	IBOutlet UIScrollView *mScrollView;
	IBOutlet UILabel *mTextLabel;
}

@end
