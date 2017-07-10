//
//  AMPImageModel.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

#import <UIKit/UIKit.h>

typedef void(^AMPImageModelLoadingCompletionHandler)(UIImage *image, NSError *error);

@class AMPImageModelCache;

@interface AMPImageModel : AMPModel
@property (nonatomic, readonly) NSURL       *url;
@property (nonatomic, readonly) UIImage     *image;
@property (nonatomic, readonly) NSString    *imagePath;
@property (nonatomic, readonly) NSString    *imageName;

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

// this method is intended for subclassing, do not call it directly
// subclasses must call completionHandler after loading is finished
- (void)performImageLoadingWithCompletionHandler:(AMPImageModelLoadingCompletionHandler)handler;

// this method is intended for subclassing, suclasses must call it after loading is finished
- (void)finishLoadingWithImage:(UIImage *)image error:(NSError *)error;

// in default implemmentation
+ (AMPImageModelCache *)imageCache;
- (AMPImageModelCache *)imageCache;


@end
