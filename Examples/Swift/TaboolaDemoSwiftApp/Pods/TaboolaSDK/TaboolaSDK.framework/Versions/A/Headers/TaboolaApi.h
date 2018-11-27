//
//  TaboolaApi.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBRecommendationRequest.h"
#import "TBRecommendationResponse.h"

typedef void(^TBRecommendationRequestSuccessCallback)(TBRecommendationResponse *response);
typedef void(^TBRecommendationRequestFailureCallback)(NSError *error);

@protocol TaboolaApiClickDelegate <NSObject>
- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic;
@end

@interface TaboolaApi : NSObject

@property (nonatomic, readonly) NSString *apiKey;
@property (nonatomic, readonly) NSString *publisherId;
@property (nonatomic, weak) id<TaboolaApiClickDelegate> clickDelegate;


//call this method in AppDelegate
- (void)startWithPublisherID:(NSString *)publisherId
                   andApiKey:(NSString *)apiKey;
- (void)fetchRecommendations:(TBRecommendationRequest *)recommendationsRequest
                   onSuccess:(TBRecommendationRequestSuccessCallback)onSuccess
                   onFailure:(TBRecommendationRequestFailureCallback)onFailure;
- (void)getNextBatchForPlacement:(TBPlacement *)placement
                      itemsCount:(NSInteger)count
                       onSuccess:(TBRecommendationRequestSuccessCallback)onSuccess
                       onFailure:(TBRecommendationRequestFailureCallback)onFailure;
+ (instancetype) sharedInstance;

- (void)setOnClickIgnorePeriod:(NSTimeInterval) ignorePeriod;
- (NSTimeInterval)onClickIgnorePeriod;

- (void)handleAttributionClick;
- (void)setExtraPropetries:(NSDictionary *)properties;
@end
