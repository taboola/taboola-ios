//
//  DfpTaboolaEventBanner.m
//  TaboolaView
//
//  Created by Vasyl Human on 2/22/17.
//  Copyright © 2017 Taboola. All rights reserved.
//

#import "DfpTaboolaEventBanner.h"
#import "TaboolaView.h"

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
    
    NSData *jsonData = [serverParameter dataUsingEncoding:NSUTF8StringEncoding];
    if (jsonData != nil){
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
        self.taboolaView.publisher = dictionary[@"publisher"];
        self.taboolaView.mode = dictionary[@"mode"];
        self.taboolaView.pageUrl = dictionary[@"url"];
        self.taboolaView.pageType = dictionary[@"article"];
        self.taboolaView.placement = dictionary[@"referrer"];
        
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
