/*
 This program is licensed under the Taboola, Inc. SDK License Agreement (the “License Agreement”).
 By copying, using or redistributing this program, you agree to the terms of the License Agreement.
 The full text of the license agreement can be found at https://github.com/taboola/taboola-ios/blob/master/LICENSE
 
 Copyright 2017 Taboola, Inc.  All rights reserved.
 */

#import "MoPubCustomEventBanner.h"
#import "TaboolaView.h"

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
    self.taboolaView.publisher          = info[@"publisher"];
    self.taboolaView.mode               = info[@"mode"];
    self.taboolaView.pageUrl            = info[@"url"];
    self.taboolaView.pageType           = info[@"article"];
    self.taboolaView.placement          = info[@"placement"];
    self.taboolaView.targetType         = info[@"target_type"];
    self.taboolaView.mediation          = @"MoPub";
    
    [self.delegate bannerCustomEvent:self didLoadAd:self.taboolaView];
    [self.taboolaView fetchContent];
}

#pragma mark TaboolaViewDelegate implementation

- (void)taboolaDidFailAd:(NSError *)error {
    [self.delegate bannerCustomEvent:self didFailToLoadAdWithError:error];
}

- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic {
    [self.delegate bannerCustomEventWillBeginAction:self];
    [self.delegate bannerCustomEventDidFinishAction:self];
    return YES;
}
@end
