//
//  TBTestViewController.h
//  TaboolaDemoApp
//

#import <UIKit/UIKit.h>
#import <TaboolaSDK/TaboolaView.h>

@interface TBTestViewController : UIViewController <TaboolaViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet TaboolaView *taboolaView;

@end
