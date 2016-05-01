//
//  MGSpotyCollection.h
//  MGSpotyCollection
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

#import "MGSpotyCollectionViewCell.h"
#import "MGSpotyCollectionViewController.h"

@import UIKit;

@interface MGSpotyCollection : UIView

@property (nonatomic, weak) UIView *overview;
@property (nonatomic, weak) UICollectionView *collectionView;

@end
