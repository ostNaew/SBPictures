//
//  DownloadOperation.m
//  
//
//  Created by 17495310 on 07/06/2019.
//
#define URL_FOR_IMAGES @"https://picsum.photos/200"

#import "../../PictureManager/SBPictureManager.h"
#import "DownloadOperation.h"
#import "SBSecondScreenManager.h"
#import "../../PictureManager/SBPictureManager.h"

@implementation DownloadOperation

- (void)start {
    if (self.isCancelled) {
        [self cancelOperation];
        return;
    }
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self main];
    });
}

-(void)main {
    if (self.isCancelled) {
        [self cancelOperation];
        return;
    }
    self.apiService = [[SBPictureManager alloc] init];
    __weak typeof (self) weakSelf = self;
    [self.apiService loadPictureWithCompletionHandler:^(UIImage *pictureForCell) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (self.isCancelled) {
            [self cancelOperation];
            return;
        }
        if (strongSelf.finisherBlock) {
            strongSelf.finisherBlock(pictureForCell);
            [self completeOperation];
            //check it 
        }
    }];
    
}
- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    executing = NO;
    finished = YES;
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

- (void)cancelOperation {
    if (!self.isFinished) {
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
    }
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

@end
