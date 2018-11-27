//
//  TBPlacement.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBItem.h"

@interface TBPlacement : NSObject
@property (nonatomic, copy) NSString *placementName;
@property (nonatomic, copy) NSString *placementId;
@property (nonatomic, copy) NSArray<TBItem *> *listOfItems;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
