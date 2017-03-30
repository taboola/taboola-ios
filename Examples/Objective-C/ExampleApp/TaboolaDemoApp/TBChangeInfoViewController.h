//
//  TBChangeInfoViewController.h
//  TaboolaDemoApp
//

#import <UIKit/UIKit.h>

@interface TBChangeInfoViewController : UIViewController

@property (copy) void(^callback)(NSMutableDictionary *widgetAttributes);

@end
