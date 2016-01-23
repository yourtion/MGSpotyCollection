//
//  MGSpotyCollectionViewController.h
//  MGSpotyCollectionViewController
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

@import UIKit;

#import "MGSpotyCollection.h"
#import "MGSpotyCollectionViewCell.h"

extern CGFloat const kMGOffsetEffects;
extern CGFloat const kMGOffsetBlurEffect;

@interface MGSpotyCollectionViewController : UIViewController

/**
 *  Main TableView object
 */
@property (nonatomic, strong) UICollectionView *collectionView;

/**
 *  Overview object
 */
@property (nonatomic, strong) UIView *overView;

/**
 *  Main image view
 */
@property (nonatomic, strong) UIImageView *mainImageView;

/**
 *  Initialize method for MGSpotyViewController
 *
 *  @param image UIImage you want to use
 *
 *  @return MGSpotyViewController
 */
- (instancetype)initWithMainImage:(UIImage *)image andIconCount:(int)count;

/**
 *  Set an UIImage for the mainImageView
 *
 *  @param image UIImage you want to use
 */
- (void)setMainImage:(UIImage *)image;

/**
 *  Register class for the tableview
 *
 *  @param cellClass  cell class
 *  @param identifier cell isdentifier
 */
- (void)registerCellClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

- (void)collectionView:(MGSpotyCollectionViewController *)viewController didSelectItemAtIndex:(NSInteger)index;

@end