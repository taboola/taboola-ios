//
//  TBPlacementRequest.h
//  TaboolaView
//
//  Copyright © 2017 Taboola. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBPlacementRequest : NSObject

@property (nonatomic, copy) NSString* name;
@property (nonatomic) NSUInteger recCount;
@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

-(void)setThumbnailSize:(CGSize)size;

@end
