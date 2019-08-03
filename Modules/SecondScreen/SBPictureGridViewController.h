//
//  SBPictureGridViewController.h
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBSecondScreenManager.h"

@class SBPicturesCollectionViewCell;

typedef enum loadOption {
    loadOptionOperation = 1,
    loadOptionDataTask,
} LoadOption;

@interface SBPictureGridViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property UICollectionView *collectionView;
@property SBSecondScreenManager *manager;
@property (nonatomic, strong) NSOperationQueue *imageOperationQueue;
@property (nonatomic, strong) NSCache *imageCache;
@property (strong, nonatomic) UIImage *picture;
@property (nonatomic) LoadOption option;

- (void)collectionView:(UICollectionView *)collectionView configureRowsAtIndexPaths:(NSArray *)indexPaths;
-(void)operationForCell:(SBPicturesCollectionViewCell *)cell andIndexPath:(NSIndexPath*)indexPath;
- (void)configureVisibleCellsForTableView:(UICollectionView *)collectionView;

@end

