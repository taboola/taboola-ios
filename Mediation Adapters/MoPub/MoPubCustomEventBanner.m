/*
 This program is licensed under the Taboola, Inc. SDK License Agreement (the “License Agreement”).
 By copying, using or redistributing this program, you agree to the terms of the License Agreement.
 The full text of the license agreement can be found at https://github.com/taboola/taboola-ios/blob/master/LICENSE
 
 Copyright 2017 Taboola, Inc.  All rights reserved.
 */

#import "MoPubCustomEventBanner.h"
#import "TaboolaView.h"

static NSString const *kPublisherKey = @"publisher";
static NSString const *kModeKey = @"mode";
static NSString const *kUrlKey = @"url";
static NSString const *kArticleKey = @"article";
static NSString const *kPlacementKey = @"placement";

@interface MoPubCustomEventBanner() <TaboolaViewDelegate>
@property (nonatomic, strong) TaboolaView *taboolaView;
@end

@implementation MoPubCustomEventBanner

@synthesize delegate;

- (void)requestAdWithSize:(CGSize)size customEventInfo:(NSDictionary *)info {
    self.taboolaView = [[TaboolaView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.taboolaView.delegate           = self;
    self.taboolaView.autoResizeHeight   = YES;
    self.taboolaView.enableClickHandler = YES;
    self.taboolaView.publisher          = info[kPublisherKey];
    self.taboolaView.mode               = info[kModeKey];
    self.taboolaView.pageUrl            = info[kUrlKey];
    self.taboolaView.pageType           = info[kArticleKey];
    self.taboolaView.placement          = info[kPlacementKey];
    self.taboolaView.mediation          = @"MoPub";
    
    NSArray* arrayOfKeys = @[kPublisherKey, kModeKey, kUrlKey, kArticleKey, kPlacementKey];
    NSMutableDictionary *pageDictionary = [NSMutableDictionary new];
    
    for (NSString *key in info.allKeys) {
        if (![arrayOfKeys containsObject:key]) {
            pageDictionary[key] = info[key];
        }
    }
    [self.taboolaView setOptionalPageCommands:pageDictionary];
    [self.taboolaView fetchContent];
}

#pragma mark TaboolaViewDelegate implementation

- (void)taboolaDidReceiveAd:(UIView *)view {
    [self.delegate bannerCustomEvent:self didLoadAd:self.taboolaView];
}

- (void)taboolaDidFailAd:(NSError *)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic {
    [self.delegate bannerCustomEventWillBeginAction:self];
    [self.delegate bannerCustomEventDidFinishAction:self];
    return YES;
}
@end
