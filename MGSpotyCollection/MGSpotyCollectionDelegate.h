//
//  MGSpotyDelegate.h
//  MGSpotyDelegate
//
//  Created by YourtionGuo on 1/19/16.
//  Copyright © 2016 Yourtion. All rights reserved.
//

@import Foundation;
@import UIKit;

@class MGSpotyViewController;
@protocol MGSpotyCollectionDelegate <NSObject>

@optional
- (CGFloat)spotyViewController:(MGSpotyViewController *)spotyViewController
    heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)spotyViewController:(MGSpotyViewController *)spotyViewController
         viewForHeaderInSection:(NSInteger)section;
- (CGFloat)spotyViewController:(MGSpotyViewController *)spotyViewController
      heightForHeaderInSection:(NSInteger)section;
- (NSString *)spotyViewController:(MGSpotyViewController *)spotyViewController
          titleForHeaderInSection:(NSInteger)section;

@end