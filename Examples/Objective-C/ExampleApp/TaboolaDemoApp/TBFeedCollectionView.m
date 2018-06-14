//
//  ViewController.m
//  UICollectionViewAppWithTaboola
//
//  Created by Yaromyr Oleksyshun on 5/25/18.
//  Copyright © 2018 Vakoms. All rights reserved.
//

#import "TBFeedCollectionView.h"
#import "TaboolaCollectionViewCell.h"

@interface TBFeedCollectionView () <TaboolaViewDelegate>

#pragma mark - Properties
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (nonatomic) TaboolaCollectionViewCell* taboolaCell;
@end

@implementation TBFeedCollectionView {
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
    self.flowLayout.estimatedItemSize = CGSizeMake(200, 200);
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == taboolaSection ? 1 : 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath.section == taboolaSection ? CGSizeMake(self.view.frame.size.width, TaboolaView.widgetHeight) : CGSizeMake(self.view.frame.size.width, 200);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([indexPath section] == taboolaSection) {
        if (!self.taboolaCell) {
            self.taboolaCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TaboolaCell" forIndexPath:indexPath];
            self.taboolaCell.taboolaView.delegate = self;
            self.taboolaCell.taboolaView.mode = @"thumbnails-feed";
            self.taboolaCell.taboolaView.publisher = @"betterbytheminute-app";
            self.taboolaCell.taboolaView.pageType = @"article";
            self.taboolaCell.taboolaView.pageUrl = @"http://www.example.com";
            self.taboolaCell.taboolaView.placement = @"feed-sample-app";
            self.taboolaCell.taboolaView.targetType = @"mix";
            self.taboolaCell.taboolaView.enableClickHandler = YES;
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
- (BOOL)taboolaViewItemClickHandler:(NSString *)pURLString :(BOOL)isOrganic{
    NSLog(@"Start load request on first screen: %@ isOrganic? %@", pURLString, isOrganic ? @"YES":@"NO");
    if (isOrganic) {
        NSLog(@"organic items should open as native app pages.");
    }
    return YES;
}

- (void)taboolaDidReceiveAd:(UIView *)view{
    NSLog(@"Delegate: didReceiveAd event");
}

- (void)taboolaDidFailAd:(NSError *)error  {
    NSLog(@"Delegate: didFailAd event");
}

- (void)taboolaViewResizedToHeight:(CGFloat)height {

}

@end


