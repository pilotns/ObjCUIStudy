//
//  AMPFileSystemImageModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFileSystemImageModel.h"

@implementation AMPFileSystemImageModel

#pragma mark -
#pragma mark Accessors

- (NSString *)imagePath {
    return self.url.path;
}

#pragma mark -
#pragma mark Public Methods

- (void)performImageLoadingWithCompletionHandler:(AMPImageModelLoadingCompletionHandler)handler {
    NSError *error = nil;
    NSData *imageData = [NSData dataWithContentsOfFile:self.imagePath
                                               options:NSDataReadingMappedAlways
                                                 error:&error];
    
    UIImage *image = [UIImage imageWithData:imageData];
    if (handler) {
        handler(image, error);
    }
}

@end
