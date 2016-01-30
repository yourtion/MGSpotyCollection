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
        _iconImage  = [[UIImageView alloc] init];
        [self.contentView addSubview:_iconImage];
        [_iconImage setTranslatesAutoresizingMaskIntoConstraints:NO];

        _textLable = [[UILabel alloc] init];
        _textLable.textAlignment = NSTextAlignmentCenter;
        _textLable.textColor = [UIColor darkGrayColor];
        _textLable.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_textLable];
        [_textLable setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.backgroundColor = [UIColor whiteColor];

        NSLayoutConstraint *constrant1i = [NSLayoutConstraint constraintWithItem:_iconImage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        NSLayoutConstraint *constrant2i = [NSLayoutConstraint constraintWithItem:_iconImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-10.0];
        NSLayoutConstraint *constrant3i = [NSLayoutConstraint constraintWithItem:_iconImage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0];
        NSLayoutConstraint *constrant4i = [NSLayoutConstraint constraintWithItem:_iconImage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60.0];
        NSLayoutConstraint *constrant1t = [NSLayoutConstraint constraintWithItem:_textLable attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
        NSLayoutConstraint *constrant2t = [NSLayoutConstraint constraintWithItem:_textLable attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:45.0];
        NSLayoutConstraint *constrant3t = [NSLayoutConstraint constraintWithItem:_textLable attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:80.0];
        NSLayoutConstraint *constrant4t = [NSLayoutConstraint constraintWithItem:_textLable attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:25.0];

        NSArray *constrantArray = @[constrant1i,constrant2i,constrant3i,constrant4i,constrant1t,constrant2t,constrant3t,constrant4t];
        [self addConstraints:constrantArray];
        
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

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    if (highlighted) {
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    } else {
        [UIView animateWithDuration:0.25f animations:^{} completion:^(BOOL finished) {
            self.backgroundColor = [UIColor whiteColor];
        }];
    }
}

@end
