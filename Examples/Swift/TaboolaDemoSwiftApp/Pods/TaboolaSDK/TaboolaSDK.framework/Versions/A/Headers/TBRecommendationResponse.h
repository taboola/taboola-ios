//
//  TBRecommendationResponse.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBPlacement.h"

@interface TBRecommendationResponse : NSObject

@property (nonatomic, copy, readonly) NSMutableArray<TBPlacement *> *placements;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
