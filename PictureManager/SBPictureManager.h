//
//  SBPictureManager.h
//  SBPictures
//
//  Created by 17495310 on 02/06/2019.
//  Copyright © 2019 17495310. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProtocol.h"

@protocol APIProtocol;

@interface SBPictureManager : NSObject <APIProtocol, NSURLSessionDelegate>

@property (strong, nonatomic) NSURLSession *session;

+(SBPictureManager *) sharedManager;

@end
