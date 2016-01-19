//
//  MGSpotyDataSource.h
//  MGSpotyDataSource
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

@import Foundation;
@import UIKit;

@class MGSpotyCollectionViewController;
@protocol MGSpotyCollectionDataSource <NSObject>

@required
- (NSInteger)spotyViewController:(MGSpotyCollectionViewController *)spotyViewController
           numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)spotyViewController:(MGSpotyCollectionViewController *)spotyViewController
         cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSInteger)numberOfSectionsInSpotyViewController:(MGSpotyCollectionViewController *)spotyViewController;

@end