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
        _iconImage  = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
        _iconImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_iconImage];
        
        _textLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 95, 80, 30)];
        _textLable.textAlignment = NSTextAlignmentCenter;
        _textLable.textColor = [UIColor blueColor];
        _textLable.font = [UIFont systemFontOfSize:15];
        _textLable.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:_textLable];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect{
    UIColor *border =[UIColor lightGrayColor];
    
    [self.layer addSublayer:[self addBorderLayer:border withWidth:VIEW_W(self) onY:VIEW_H(self)-0.5f]];
    
    [self.layer addSublayer:[self addLineLayer:border withHeight:VIEW_H(self) onX:0 onY:0]];
}

- (CALayer *)addBorderLayer:(UIColor *)borderColor withWidth:(float)width onY:(float)pointY
{
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(0.0f, pointY, width, 0.5f);
    border.backgroundColor = borderColor.CGColor;
    return border;
}

- (CALayer *)addLineLayer:(UIColor *)borderColor withHeight:(float)height onX:(float)pointX onY:(float)pointY
{
    CALayer *border = [CALayer layer];
    border.frame = CGRectMake(pointX, pointY, 0.5f, height);
    border.backgroundColor = borderColor.CGColor;
    return border;
}
@end
