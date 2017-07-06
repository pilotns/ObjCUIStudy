//
//  AMPFileSystemImageModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFileSystemImageModel.h"

@interface AMPFileSystemImageModel ()
@property (nonatomic, strong)   UIImage *image;

@end

@implementation AMPFileSystemImageModel

@synthesize image = _image;

#pragma mark -
#pragma mark Accessors

- (NSString *)imagePath {
    return self.url.path;
}

#pragma mark -
#pragma mark Public Methods

- (void)processLoadingImage {
    NSError *error = nil;
    NSData *imageData = [NSData dataWithContentsOfFile:self.imagePath
                                               options:NSDataReadingMappedAlways
                                                 error:&error];
    
    if (!error) {
        self.image = [UIImage imageWithData:imageData];
        self.state = AMPModelDidLoad;
    } else {
        [self setState:AMPModelDidFailLoading userInfo:error];
    }
}

@end
