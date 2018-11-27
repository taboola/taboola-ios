//
//  ViewController.m
//  UICollectionViewAppWithTaboola
//
//  Created by Yaromyr Oleksyshun on 5/25/18.
//  Copyright © 2018 Vakoms. All rights reserved.
//

#import "TBWidgetCollectionView.h"
#import "TaboolaCollectionViewCell.h"

@interface TBWidgetCollectionView () <TaboolaViewDelegate>

#pragma mark - Properties
@property (nonatomic) TaboolaCollectionViewCell* taboolaCell;
@end

@implementation TBWidgetCollectionView {
    NSUInteger taboolaCellIndex;
}


#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    taboolaCellIndex = 1;
}


#pragma mark - Supporting functions


#pragma mark - UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(self.view.frame.size.width, self.taboolaCell.taboolaView.frame.size.height > 0 ? self.taboolaCell.taboolaView.frame.size.height : 200);
    if (indexPath.item == taboolaCellIndex) {
        return size;
    } else {
        return CGSizeMake(self.view.frame.size.width, 200);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath item] == taboolaCellIndex) {
        if (!self.taboolaCell) {
            self.taboolaCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TaboolaCell" forIndexPath:indexPath];
            self.taboolaCell.taboolaView.delegate = self;
            self.taboolaCell.taboolaView.mode = @"thumbnails-sdk1";
            self.taboolaCell.taboolaView.publisher = @"betterbytheminute-app";
            self.taboolaCell.taboolaView.pageType = @"article";
            self.taboolaCell.taboolaView.pageUrl = @"https://www.weatherbug.com";
            self.taboolaCell.taboolaView.placement = @"iOS Below Article Thumbnails";
            self.taboolaCell.taboolaView.targetType = @"mix";
            self.taboolaCell.taboolaView.logLevel = LogLevelDebug;
            [self.taboolaCell.taboolaView fetchContent];
        }
        return self.taboolaCell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"randomCell" forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - TaboolaView delegate
-(void)taboolaView:(UIView *)taboolaView didLoadPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height {
    
}

-(void)taboolaView:(UIView *)taboolaView placementNamed:(NSString *)placementName resizedToHeight:(CGFloat)height {
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:taboolaCellIndex inSection:0]]];
}

- (void)taboolaView:(UIView *)taboolaView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error {
    
}

- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic {
    return YES;
}

@end


