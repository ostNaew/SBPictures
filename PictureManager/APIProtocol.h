//
//  APIProtocol.h
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APIProtocol <NSObject>

- (void)loadPictureWithCompletionHandler:(void (^)(UIImage *pictureForCell))completionHandler;

@end
