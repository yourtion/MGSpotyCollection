//
//  MyCollectionViewCell.h
//  CollectionViewDemo
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEW_W(view)  (view.frame.size.width)
#define VIEW_H(view)  (view.frame.size.height)

@interface MGSpotyCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *iconImage;

@property (strong, nonatomic) UILabel *textLable;

@end
