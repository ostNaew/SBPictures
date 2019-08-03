//
//  SBPictureGridViewController.m
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import "SBPictureGridViewController.h"
#import "SBPicturesCollectionViewCell.h"
#import "SBSecondScreenManager.h"
#import "../../PictureManager/SBPictureManager.h"
#import "../FirstScreen/SBFirstScreenViewController.h"
#import "DownloadOperation.h"

static NSString  *kPlaceholderImage = @"clear.png";
static NSString *kLabelText = @"Something";
static NSString *kCellIdentifier = @"SBPictureCell";

@interface SBPictureGridViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

//@property (strong, nonatomic) DownloadOperation* downloadOperation;

@end

@implementation SBPictureGridViewController {
    DownloadOperation* downloadOperation;
}
@synthesize collectionView = _collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%d", self.option);
    self.imageOperationQueue = [[NSOperationQueue alloc]init];
    self.imageOperationQueue.maxConcurrentOperationCount = 1;
    self.view.backgroundColor = [UIColor whiteColor];
    self.manager = [[SBSecondScreenManager alloc] init];
    self.manager.pictureArray = [NSMutableArray array];
    self.manager.apiManager = [[SBPictureManager alloc] init];
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    self.collectionView=[[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    UINib *nib = [UINib nibWithNibName:kCellIdentifier bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:kCellIdentifier];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self setConstraintsForView];
    if (self.option == 1)
        [self addSomeButtons];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SBPicturesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    [self basicCell:cell withIndexPath:indexPath];
    switch (self.option) {
        case 1:
            [self operationForCell:cell withIndexPath:indexPath];
        break;
        case 2:
            [self chaoticImageLoading:cell withIndexPath:indexPath];
        break;
    }
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize mElementSize;
    mElementSize=CGSizeMake(175, 175);
    return mElementSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 15.0;
}

- (UIEdgeInsets)collectionView: (UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15,15,20,15);  // top, left, bottom, right
}

-(void)cancelOperationsPressed:(UIBarButtonItem*)sender {
    [self.imageOperationQueue cancelAllOperations];
}

-(void)updateButtonPressed:(UIBarButtonItem*)sender {
    //or we should update only vivsble cells?
    //then we don't need so assign nil to the whole Array, but to some indexes
    self.manager.pictureArray = nil;
    [self configureVisibleCellsForTableView:self.collectionView];
}

- (void)configureVisibleCellsForTableView:(UICollectionView *)collectionView {
    self.imageOperationQueue = [[NSOperationQueue alloc]init];
    self.imageOperationQueue.maxConcurrentOperationCount = 1;
    [self collectionView:collectionView configureRowsAtIndexPaths:collectionView.indexPathsForVisibleItems];
}

- (void)collectionView:(UICollectionView *)collectionView configureRowsAtIndexPaths:(NSArray *)indexPaths {
    NSIndexPath *minNumber = [indexPaths valueForKeyPath:@"@min.self"];
    NSLog(@"%@", minNumber);
    //change this
    for (int i = (int)minNumber.item; i < (int)indexPaths.count + 2; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0]; SBPicturesCollectionViewCell *cell =(SBPicturesCollectionViewCell*) [self.collectionView cellForItemAtIndexPath:indexPath];
        [self basicCell:cell withIndexPath:indexPath];
        cell.backgroundColor = [UIColor blueColor];
        [self operationForCell:cell withIndexPath:indexPath];
    }
}

-(SBPicturesCollectionViewCell *)basicCell: (SBPicturesCollectionViewCell*)cell withIndexPath: (NSIndexPath*)indexPath{
    cell.backgroundColor = [UIColor greenColor];
    cell.cellPicture.image = [UIImage imageNamed:kPlaceholderImage];
    cell.cellLabel.text = kLabelText;
    return cell;
}

-(void)operationForCell:(SBPicturesCollectionViewCell *)cell withIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.row < [self.manager.pictureArray count]) {
        cell.cellPicture.image = self.manager.pictureArray[indexPath.row];
    }
    else {
        downloadOperation = [[DownloadOperation alloc] init];
        __weak typeof (self) weakSelf = self;
        [downloadOperation setFinisherBlock:^void(UIImage* picture){
            dispatch_async(dispatch_get_main_queue(), ^{
                __strong typeof (weakSelf) strongSelf = weakSelf;
                [strongSelf.manager.pictureArray addObject:picture];
                cell.cellPicture.image = picture;
            });
        }];
        [self.imageOperationQueue addOperation:downloadOperation];
    }
}

-(void)chaoticImageLoading:(SBPicturesCollectionViewCell*)cell withIndexPath:(NSIndexPath*)indexPath {
    __weak typeof(self) weakSelf = self;
    [self.manager loadPictureForCell:indexPath.row completionHandler:^(NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        cell.cellPicture.image = strongSelf.manager.picture;
    }];
}

-(void)addSomeButtons {
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelOperationsPressed:)];
    //[self.navigationItem setRightBarButtonItem:cancel];
    UIBarButtonItem *update = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(updateButtonPressed:)];
    self.navigationItem.rightBarButtonItems = @[cancel, update];
}

-(void)setConstraintsForView {
    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
                                              [self.collectionView.topAnchor constraintEqualToAnchor:guide.topAnchor constant:0],
                                              [self.collectionView.leftAnchor constraintEqualToAnchor:guide.leftAnchor constant:0],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:guide.bottomAnchor constant:0],
                                              [self.collectionView.rightAnchor constraintEqualToAnchor:guide.rightAnchor constant:0],
                                              ]];
}

@end
