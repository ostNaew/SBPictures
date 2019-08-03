//
//  SBSecondScreenManager.h
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SBPictureManager;

@interface SBSecondScreenManager : NSObject

@property SBPictureManager *apiManager;
@property UIImage *picture;
//change mutable array to a normal one
@property NSMutableArray *pictureArray;
@property NSOperationQueue *queue;
-(void)loadPictureForCell:(NSInteger)index completionHandler:(void (^)(NSError * error))completionHandler;

@end

