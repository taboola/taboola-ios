//
//  TBRecommendationRequest.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBPlacementRequest.h"

typedef enum {
    TBSourceTypeVideo,
    TBSourceTypeText,
    TBSourceTypePhoto,
    TBSourceTypeHome,
    TBSourceTypeSection,
    TBSourceTypeSearch
} TBSourceType;

@interface TBRecommendationRequest : NSObject

@property (nonatomic) TBSourceType sourceType;
@property (nonatomic, copy) NSString *targetType;

- (void)setPageUrl:(NSString*)url;
- (void)setSourceId:(NSString *)sourceId;
- (void)setUserReferrer:(NSString*) referrer;
- (void)setUnidiedId:(NSString*) unifiedId;

- (NSDictionary *)parameters;
- (void)addPlacementRequest:(TBPlacementRequest *)parameters;

- (instancetype)createNextBatchRequest:(NSString *)placementName itemsCount:(NSUInteger)itemsCount;

@end
