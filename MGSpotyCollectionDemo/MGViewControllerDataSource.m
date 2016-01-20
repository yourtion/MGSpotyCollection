//
//  MGViewControllerDataSource.m
//  MGSpotyView
//
//  Created by Daniele Bogo on 08/08/2015.
//  Copyright (c) 2015 Matteo Gobbi. All rights reserved.
//

#import "MGViewControllerDataSource.h"
#import "MGSpotyCollectionViewController.h"
#import "MGSpotyCollectionViewCell.h"

@implementation MGViewControllerDataSource


#pragma mark - MGSpotyViewControllerDataSource

- (NSInteger)spotyViewController:(MGSpotyViewController *)spotyViewController
           numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)spotyViewController:(MGSpotyCollectionViewController *)spotyViewController
                   cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"CellID";
    MGSpotyCollectionViewCell *cell = [spotyViewController.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell) {
        cell = [[MGSpotyCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, 120, 150)];
        cell.backgroundColor = [UIColor darkGrayColor];
    }
    
//    cell.textLabel.text = @"Cell";
    
    return cell;
}

@end
