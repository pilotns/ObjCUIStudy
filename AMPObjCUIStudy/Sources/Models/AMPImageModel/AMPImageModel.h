//
//  AMPImageModel.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

#import <UIKit/UIKit.h>

typedef void(^AMPImageModelLoadingCompletionHandler)(UIImage *image);

@class AMPImageModelCache;

@interface AMPImageModel : AMPModel
@property (nonatomic, readonly) NSURL       *url;
@property (nonatomic, readonly) UIImage     *image;
@property (nonatomic, readonly) NSString    *imagePath;
@property (nonatomic, readonly) NSString    *imageName;

@property (nonatomic, readonly) AMPImageModelCache  *imageCache;

+ (AMPImageModelCache *)imageCache;

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

// this method is intended for subclassing, do not call it directly
// subclasses must call completionHandler after loading is finished
- (void)performImageLoadingWithCompletionHandler:(AMPImageModelLoadingCompletionHandler)handler;


@end
