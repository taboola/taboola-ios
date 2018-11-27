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
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) TaboolaCollectionViewCell* taboolaCell;
@end

@implementation TBWidgetCollectionView {
    NSUInteger taboolaSection;
}


#pragma mark - ViewController lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    taboolaSection = 1;
    [self setupCollectionView];
}


#pragma mark - Supporting functions
- (void)setupCollectionView {
    [self.collectionView registerNib:[UINib nibWithNibName:@"TaboolaCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TaboolaCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"randomCell" bundle:nil] forCellWithReuseIdentifier:@"randomCell"];
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == taboolaSection ? 1 : 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeMake(self.view.frame.size.width, self.taboolaCell.taboolaView.frame.size.height > 0 ? self.taboolaCell.taboolaView.frame.size.height : 200);
    if (indexPath.section == taboolaSection) {
        return size;
    } else {
        return CGSizeMake(self.view.frame.size.width, 200);
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath section] == taboolaSection) {
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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.collectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - TaboolaView delegate
-(void)taboolaView:(UIView *)taboolaView didLoadPlacementNamed:(NSString *)placementName withHeight:(CGFloat)height {
    
}

-(void)taboolaView:(UIView *)taboolaView placementNamed:(NSString *)placementName resizedToHeight:(CGFloat)height {
    NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:taboolaSection];
    [self.collectionView reloadSections:set];
}

- (void)taboolaView:(UIView *)taboolaView didFailToLoadPlacementNamed:(NSString *)placementName withErrorMessage:(NSString *)error {
    
}

- (BOOL)onItemClick:(NSString *)placementName withItemId:(NSString *)itemId withClickUrl:(NSString *)clickUrl isOrganic:(BOOL)organic {
    return YES;
}

@end


