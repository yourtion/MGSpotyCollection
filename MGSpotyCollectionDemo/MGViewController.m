//
//  MGViewController.m
//  MGSpotyView
//
//  Created by Matteo Gobbi on 25/06/2014.
//  Copyright (c) 2014 Matteo Gobbi. All rights reserved.
//

#import "MGViewController.h"

@interface MGViewController ()<MGSpotyCollectionDelegate> {
    NSArray *_iconArray;
    NSArray *_titleArray;
}

@end

@implementation MGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setOverView:self.myOverView];
    self.delegate = self;
    _iconArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"1",@"2",@"3",@"4",@"5",@"6"];
    _titleArray = @[@"Edit",@"Profile",@"Info",@"Mesage",@"Note",@"VIP",@"编辑",@"简介",@"信息",@"对话",@"备注",@"会员"];
}

- (UIView *)myOverView
{
    UIView *view = [[UIView alloc] initWithFrame:self.overView.bounds];
    
    [self mg_addElementOnView:view];
    
    return view;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Private methods

- (void)mg_addElementOnView:(UIView *)view
{
    //Add an example imageView
    UIView *itemsContainer = [UIView new];
    itemsContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [view addSubview:itemsContainer];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    [imageView setClipsToBounds:YES];
    [imageView setImage:[UIImage imageNamed:@"yourtion"]];
    [imageView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [imageView.layer setBorderWidth:2.0];
    [imageView.layer setCornerRadius:45.0];
    imageView.userInteractionEnabled = YES;
    [itemsContainer addSubview:imageView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tapRecognizer.numberOfTapsRequired = 1;
    [imageView addGestureRecognizer:tapRecognizer];
    
    
    //Add an example label
    UILabel *lblTitle = [UILabel new];
    lblTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [lblTitle setText:@"Yourtion Guo"];
    [lblTitle setFont:[UIFont boldSystemFontOfSize:25.0]];
    [lblTitle setTextAlignment:NSTextAlignmentCenter];
    [lblTitle setTextColor:[UIColor whiteColor]];
    lblTitle.numberOfLines = 0;
    lblTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [itemsContainer addSubview:lblTitle];
    
    
    //Add an example button
    UIButton *btContact = [UIButton buttonWithType:UIButtonTypeCustom];
    btContact.translatesAutoresizingMaskIntoConstraints = NO;
    [btContact setTitle:@"Contact" forState:UIControlStateNormal];
    [btContact addTarget:self action:@selector(actionContact:) forControlEvents:UIControlEventTouchUpInside];
    btContact.backgroundColor = [UIColor darkGrayColor];
    btContact.titleLabel.font = [UIFont fontWithName:@"Verdana" size:12.0];
    btContact.layer.cornerRadius = 5.0;
    [itemsContainer addSubview:btContact];
    
    [view addConstraint:[NSLayoutConstraint constraintWithItem:itemsContainer attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [view addConstraint:[NSLayoutConstraint constraintWithItem:itemsContainer attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    
    NSDictionary *items = NSDictionaryOfVariableBindings(imageView, lblTitle, btContact);
    [items enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [itemsContainer addConstraint:[NSLayoutConstraint constraintWithItem:obj attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:itemsContainer attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    }];
    
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[imageView(90)]" options:0 metrics:nil views:items]];
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[btContact(70)]" options:0 metrics:nil views:items]];
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[lblTitle]-10-|" options:0 metrics:nil views:items]];
    
    [itemsContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView(90)]-10-[lblTitle]-10-[btContact(30)]|" options:0 metrics:nil views:items]];
}

-(void)collectionView:(MGSpotyCollectionViewController *)viewController didSelectItemAtIndex:(NSInteger)index{
    NSString *title = @"Unknow";
    if (index < _iconArray.count && index < _titleArray.count) {
        title = _titleArray[index];
    }
    NSString *msg = [NSString stringWithFormat:@"Pressed Cell - %ld -%@", (long)index, title];
    [[[UIAlertView alloc] initWithTitle:@"Cell" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)collectionView:(MGSpotyCollectionViewController *)viewController setIconAndTitleForCell:(MGSpotyCollectionViewCell *)cell atIndex:(NSInteger)index{

    if (index < _iconArray.count && index < _titleArray.count) {
        UIImage *image = [UIImage imageNamed:_iconArray[index]];
        NSString *title = _titleArray[index];
        if(image && title) {
            cell.iconImage.image = image;
            cell.textLable.text = title;
        }
    } else {
        cell.iconImage.image = [UIImage imageNamed:@"yourtion"];
        cell.textLable.text = @"Unknow";
    }
}

#pragma mark - Action

- (void)actionContact:(id)sender
{
    [[[UIAlertView alloc] initWithTitle:@"Contact" message:@"Pressed button Contact" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


#pragma mark - Gesture recognizer

- (void)handleTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [[[UIAlertView alloc] initWithTitle:@"Gesture recognizer" message:@"Touched image" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}


@end