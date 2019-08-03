//
//  SBPictureManager.m
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import "SBPictureManager.h"
#import "APIProtocol.h"
#import <UIKit/UIKit.h>

static NSString *kSBUrlForImage = @"https://picsum.photos/200";

@implementation SBPictureManager

static SBPictureManager *sharedManager = nil;

- (void)loadPictureWithCompletionHandler:(void (^)(UIImage *pictureForCell))completionHandler {
    NSURL *url = [NSURL URLWithString:kSBUrlForImage];
    NSURLSessionDataTask *imageTask = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *pictureForCell = [UIImage imageWithData:data];
        if (completionHandler) {
          dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(pictureForCell);
            });
        }
    }];
    [imageTask resume];
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler{
    
    if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){
        if([challenge.protectionSpace.host isEqualToString:@"picsum.photos"]){
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential,credential);
        }
    }
}

+(SBPictureManager *) sharedManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[super alloc] init];
    });
    
    return sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:sessionConfiguration delegate:self delegateQueue:nil];
    }
    return self;
}

//-(void)showPictureForOperation {
//    NSURL *url = [NSURL URLWithString:URL_FOR_IMAGES];
//    NSURLSessionDownloadTask *downloadPhotoTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
//        UIImage *downloadedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:location]];
//    }];
//    [downloadPhotoTask resume];
//}

@end
