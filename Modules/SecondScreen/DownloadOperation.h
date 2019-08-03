//
//  DownloadOperation.h
//  
//
//  Created by 17495310 on 07/06/2019.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SBSecondScreenManager.h"
#import "SBPicturesCollectionViewCell.h"

@interface DownloadOperation : NSOperation {
    BOOL executing;
    BOOL finished;
}

@property NSMutableArray *pictureArray;
@property (strong, nonatomic) SBPictureManager *apiService;
@property (copy, nonatomic) void(^finisherBlock)(UIImage*);

@end
