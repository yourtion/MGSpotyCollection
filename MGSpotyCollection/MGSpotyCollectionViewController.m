//
//  MGSpotyViewController.m
//  MGSpotyView
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

#import "MGSpotyCollectionViewController.h"
#import "MGSpotyCollection.h"
#import "MGSpotyCollectionViewCell.h"
#import "UIImageView+LBBlurredImage.h"


CGFloat const kMGOffsetEffects = 40.0;
CGFloat const kMGOffsetBlurEffect = 2.0;

static const CGFloat kMGMaxPercentageOverviewHeightInScreen = 0.60f;


@interface MGSpotyCollectionViewController () <UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end


@implementation MGSpotyCollectionViewController {
    CGPoint startContentOffset_;
    CGPoint lastContentOffsetBlurEffect_;
    UIImage *image_;
    NSOperationQueue *operationQueue_;
    int iconCount;
}


#pragma mark - Life cycle

- (instancetype)initWithMainImage:(UIImage *)image andIconCount:(int)count
{
    if(self = [super init]) {
        image_ = [image copy];
        iconCount = count;
        
        _mainImageView = [UIImageView new];
        _mainImageView.image = image_;
        
        _overView = [UIView new];
        
        operationQueue_ = [[NSOperationQueue alloc]init];
        operationQueue_.maxConcurrentOperationCount = 1;
    }
    
    return self;
}

- (void)loadView
{
    //Create the view
    MGSpotyCollection *view = [[MGSpotyCollection alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.backgroundColor = [UIColor grayColor];
    
    //Configure the view
    CGFloat viewWidth = CGRectGetWidth(view.frame);
    _mainImageView.frame = (CGRect){ 0, 0, viewWidth, MIN(viewWidth, CGRectGetHeight(view.frame)*kMGMaxPercentageOverviewHeightInScreen) };
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    _mainImageView.clipsToBounds = YES;
    [_mainImageView setImageToBlur:image_ blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
    [view addSubview:_mainImageView];
    
    _overView.frame = _mainImageView.bounds;
    _overView.backgroundColor = [UIColor clearColor];
    [view addSubview:_overView];
    
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(120, 150);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc]initWithFrame:view.frame collectionViewLayout:flowLayout];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
    _collectionView.frame = view.frame;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.backgroundView = nil;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [view addSubview:_collectionView];
    
    startContentOffset_ = _collectionView.contentOffset;
    lastContentOffsetBlurEffect_ = startContentOffset_;
    
    //Pass references
    view.overview = _overView;
    view.collectionView = _collectionView;
    
    //Set the view
    self.view = view;
}


#pragma mark - Override accessor methods

- (void)setOverView:(UIView *)overView
{
    static NSUInteger subviewTag = 100;
    UIView *subView = [overView viewWithTag:subviewTag];
    
    if(![subView isEqual:overView]) {
        [subView removeFromSuperview];
        [_overView addSubview:overView];
        
        for (NSLayoutConstraint *constraint in _overView.constraints) {
            [_overView removeConstraint:constraint];
        }
        
        NSDictionary *views = NSDictionaryOfVariableBindings(overView);
        
        overView.translatesAutoresizingMaskIntoConstraints = NO;
        [_overView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[overView]-0-|" options:0 metrics:nil views:views]];
        [_overView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[overView]-0-|" options:0 metrics:nil views:views]];
    }
}

- (void)setMainImage:(UIImage *)image
{
    BOOL imageIsContained = CGRectContainsRect(_mainImageView.bounds, (CGRect){ 0, 0, image.size.width, image.size.height });
    if (!imageIsContained) {
        image = [self mg_resizeImage:image];
    }
    
    //Copying resized image & setting to blur
    image_ = [image copy];
    [_mainImageView setImageToBlur:image blurRadius:kLBBlurredImageDefaultBlurRadius completionBlock:nil];
}


#pragma mark - Public methods

- (void)registerCellClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier
{
    [_collectionView registerClass:cellClass forCellWithReuseIdentifier:identifier];
}


#pragma mark - Private methods

- (UIImage *)mg_resizeImage:(UIImage *)image
{
    CGSize sizeBeingScaledTo = [self mg_sizeAspectFill:_mainImageView.frame.size aspectRatio:image.size];
    
    UIGraphicsBeginImageContext(_mainImageView.frame.size);
    [image drawInRect:(CGRect){ 0, 0, sizeBeingScaledTo.width, sizeBeingScaledTo.height }];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

- (CGSize)mg_sizeAspectFill:(CGSize)minimumSize aspectRatio:(CGSize)aspectRatio
{
    CGFloat mW = minimumSize.width / aspectRatio.width;
    CGFloat mH = minimumSize.height / aspectRatio.height;
    if(mH > mW) {
        minimumSize.width = minimumSize.height / aspectRatio.height * aspectRatio.width;
    } else if( mW > mH ) {
        minimumSize.height = minimumSize.width / aspectRatio.width * aspectRatio.height;
    }
    return minimumSize;
}

- (void)mg_didRotateToSize:(CGSize)size
{
    CGFloat newH = MIN(size.height*kMGMaxPercentageOverviewHeightInScreen, size.width);
    
    CGRect rect = _overView.frame;
    rect.size.width = size.width;
    rect.size.height = newH;
    
    _overView.frame = rect;
    _mainImageView.frame = rect;
    _collectionView.frame = (CGRect){ 0, 0, size.width, size.height };
    
    //Clear
    _collectionView.contentOffset = (CGPoint){ 0, 0 };
    startContentOffset_ = _collectionView.contentOffset;
    lastContentOffsetBlurEffect_ = startContentOffset_;
}


#pragma mark - Rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    [self mg_didRotateToSize:(CGSize){ CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds) }];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [self mg_didRotateToSize:size];
}


#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //Image size effects
    CGFloat absoluteY = ABS(scrollView.contentOffset.y);
    CGFloat overviewWidth = CGRectGetWidth(_overView.frame);
    CGFloat overviewHeight = CGRectGetHeight(_overView.frame);
    
    if(scrollView.contentOffset.y <= startContentOffset_.y) {
        _overView.frame = (CGRect){ 0.0, absoluteY, overviewWidth, overviewHeight };
        
        CGFloat diff = startContentOffset_.y - scrollView.contentOffset.y;
        CGFloat newH = scrollView.contentOffset.y <= 0 ? overviewHeight + absoluteY : overviewHeight;
        CGFloat newW = scrollView.contentOffset.y <= 0 ? (newH * overviewWidth) / newH : overviewWidth;
        
        _mainImageView.frame = (CGRect){ 0.0, 0.0, newW, newH };
        
        if(scrollView.contentOffset.y < startContentOffset_.y-kMGOffsetEffects) {
            diff = kMGOffsetEffects;
        }
        
        //Image blur effects
        CGFloat scale = kLBBlurredImageDefaultBlurRadius/kMGOffsetEffects;
        CGFloat newBlur = kLBBlurredImageDefaultBlurRadius - diff*scale;
        
        __block typeof (_overView) overView = _overView;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //Blur effects
            if(ABS(lastContentOffsetBlurEffect_.y-scrollView.contentOffset.y) >= kMGOffsetBlurEffect) {
                lastContentOffsetBlurEffect_ = scrollView.contentOffset;
                [_mainImageView setImageToBlur:image_ blurRadius:newBlur completionBlock:nil];
            }
            
            //Opacity overView
            CGFloat scale = 1.0/kMGOffsetEffects;
            overView.alpha = 1.0 - diff*scale;
        });
    } else {
        _overView.frame = (CGRect){ 0.0, -absoluteY, overviewWidth, overviewHeight };
        _mainImageView.frame = (CGRect){ 0.0, -absoluteY, overviewWidth, overviewHeight };
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSpotyViewController:)]) {
        return [self.dataSource numberOfSectionsInSpotyViewController:self];
    }
    
    return iconCount;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CellID";
    MGSpotyCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell) {
        cell = [[MGSpotyCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 120, 150)];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    return cell;
}



#pragma mark - UITableViewDelegate

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(120, 150);
}

//header的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return self.overView.frame.size;
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//通过设置SupplementaryViewOfKind 来设置头部或者底部的view，其中 ReuseIdentifier 的值必须和 注册是填写的一致，本例都为 “reusableView”
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor =[UIColor clearColor];
    headerView.frame =self.overView.bounds ;
    return headerView;
}




@end