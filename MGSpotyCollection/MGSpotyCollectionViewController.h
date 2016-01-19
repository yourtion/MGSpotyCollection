//
//  MGSpotyCollectionViewController.h
//  MGSpotyCollectionViewController
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

@import UIKit;

#import "MGSpotyCollectionDataSource.h"
#import "MGSpotyCollectionDelegate.h"


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
 *  The MGSpotyViewController dataSource. This protocol wraps the tableview datasource
 */
@property (nonatomic, weak) id <MGSpotyCollectionDataSource> dataSource;

/**
 *  The MGSpotyViewController delegate. This protocol wraps the tableview delegate
 */
@property (nonatomic, weak) id <MGSpotyCollectionDelegate> delegate;

/**
 *  Initialize method for MGSpotyViewController
 *
 *  @param image UIImage you want to use
 *
 *  @return MGSpotyViewController
 */
- (instancetype)initWithMainImage:(UIImage *)image;

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

@end