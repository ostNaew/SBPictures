//
//  SBSecondScreenManager.m
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import "SBSecondScreenManager.h"
#import "../../PictureManager/SBPictureManager.h"

#define URL_FOR_IMAGES @"https://picsum.photos/200"

@implementation SBSecondScreenManager

-(void)loadPictureOperative:(NSInteger)index {
    
    [self.queue addOperationWithBlock:^{
        NSString *urlString = [NSString stringWithFormat:URL_FOR_IMAGES];
        NSURL *imageurl = [NSURL URLWithString:urlString];
        UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
        if (img != nil) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self.pictureArray addObject:img];
            }];
        }
    }];
}

-(void)loadPictureForCell:(NSInteger)index completionHandler:(void (^)(NSError *error))completionHandler {
    __weak typeof(self) weakSelf = self;
    NSError *error;
    if (index < [self.pictureArray count]) {
        self.picture = self.pictureArray[index];
        if (completionHandler)
            completionHandler(error);
    }
    else {
        [self.apiManager loadPictureWithCompletionHandler:^(UIImage *pictureForCell) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.picture = pictureForCell;
            [strongSelf.pictureArray addObject:pictureForCell];
            if (completionHandler) {
                completionHandler(error);
            }
        }];
    }
}

//-(void)loadPictureForManager {
//    NSOperation *operation = [NSOperation ]
//}

@end
