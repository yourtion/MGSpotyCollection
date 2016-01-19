//
//  MyCollectionViewCell.m
//  CollectionViewDemo
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

#import "MGSpotyCollectionViewCell.h"

@implementation MGSpotyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _topImage  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 80, 80)];
        _topImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_topImage];
        
        _botlabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 80, 30)];
        _botlabel.textAlignment = NSTextAlignmentCenter;
        _botlabel.textColor = [UIColor blueColor];
        _botlabel.font = [UIFont systemFontOfSize:15];
        _botlabel.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_botlabel];
    }
    
    return self;
}

@end
