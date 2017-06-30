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
@property (nonatomic, readonly)   UIImage *image;

+ (instancetype)imageModelWithURL:(NSURL *)url;

- (instancetype)initWithURL:(NSURL *)url;


@end
