/*
 This program is licensed under the Taboola, Inc. SDK License Agreement (the “License Agreement”).
 By copying, using or redistributing this program, you agree to the terms of the License Agreement.
 The full text of the license agreement can be found at https://github.com/taboola/taboola-ios/blob/master/LICENSE
 
 Copyright 2017 Taboola, Inc.  All rights reserved.
 */

#import "DfpTaboolaEventBanner.h"
#import "TaboolaView.h"

static NSString const *kPublisherKey = @"publisher";
static NSString const *kModeKey = @"mode";
static NSString const *kUrlKey = @"url";
static NSString const *kArticleKey = @"article";
static NSString const *kPlacementKey = @"placement";

@interface DfpTaboolaEventBanner() <TaboolaViewDelegate>
@property (nonatomic, strong) TaboolaView *taboolaView;
@end

@implementation DfpTaboolaEventBanner

@synthesize delegate;

- (void)requestBannerAd:(GADAdSize)adSize
              parameter:(NSString *)serverParameter
                  label:(NSString *)serverLabel
                request:(GADCustomEventRequest *)request {
    self.taboolaView = [[TaboolaView alloc] initWithFrame:CGRectMake(0, 0, adSize.size.width, adSize.size.height)];
    self.taboolaView.delegate = self;
    self.taboolaView.autoResizeHeight = YES;
    self.taboolaView.enableClickHandler = YES;
    self.taboolaView.mediation = @"DFP";
    
    NSData *jsonData = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData != nil){
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        self.taboolaView.publisher  = dictionary[kPublisherKey];
        self.taboolaView.mode       = dictionary[kModeKey];
        self.taboolaView.pageUrl    = dictionary[kUrlKey];
        self.taboolaView.pageType   = dictionary[kArticleKey];
        self.taboolaView.placement  = dictionary[kPlacementKey];
        
        NSArray* arrayOfKeys = @[kPublisherKey, kModeKey, kUrlKey, kArticleKey, kPlacementKey];
        NSMutableDictionary *pageDictionary = [NSMutableDictionary new];
        
        for (NSString *key in dictionary.allKeys) {
            if (![arrayOfKeys containsObject:key]) {
                pageDictionary[key] = dictionary[key];
                [self.taboolaView setOptionalPageCommands:pageDictionary];
            }
        }
        
        [self.delegate customEventBanner:self didReceiveAd:self.taboolaView];
    }
    
    [self.taboolaView fetchContent];
}

#pragma mark TaboolaViewDelegate implementation

- (void)taboolaDidFailAd:(NSError *)error {
    [self.delegate customEventBanner:self didFailAd:error];
}

- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic {
    [self.delegate customEventBannerWasClicked:self];
    [self.delegate customEventBannerWillLeaveApplication:self];
    return YES;
}

@end


