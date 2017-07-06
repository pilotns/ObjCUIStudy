//
//  AMPImageModel.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

#import <UIKit/UIKit.h>

@interface AMPImageModel : AMPModel
@property (nonatomic, readonly) NSURL       *url;
@property (nonatomic, readonly) UIImage     *image;
@property (nonatomic, readonly) NSString    *imagePath;
@property (nonatomic, readonly) NSString    *imageName;

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;

// this method is intended for subclassing^ do not call it directly
- (void)processLoadingImage;


@end
