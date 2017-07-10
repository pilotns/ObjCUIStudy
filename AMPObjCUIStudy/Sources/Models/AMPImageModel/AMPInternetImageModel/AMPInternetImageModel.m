//
//  AMPInternetImageModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPInternetImageModel.h"

#import "NSFileManager+AMPExtensions.h"

@interface AMPInternetImageModel ()
@property (nonatomic, readonly)     NSURLSession                *session;
@property (nonatomic, strong)       NSURLSessionDownloadTask    *imageLoadingTask;

@end

@implementation AMPInternetImageModel

#pragma mark -
#pragma mark Initializations and Deallocation

- (void)dealloc {
    self.imageLoadingTask = nil;
}

#pragma mark -
#pragma mark Accessros

- (NSURLSession *)session {
    return [NSURLSession sharedSession];
}

- (NSString *)imagePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    return [[manager URLForDirectoryInLibraryDirectory:@"Images"] URLByAppendingPathComponent:self.imageName].path;
}

- (void)setImageLoadingTask:(NSURLSessionDownloadTask *)imageLoadingTask {
    if (_imageLoadingTask != imageLoadingTask) {
        [_imageLoadingTask cancel];
        
        _imageLoadingTask = imageLoadingTask;
        [imageLoadingTask resume];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)performImageLoadingWithCompletionHandler:(AMPImageModelLoadingCompletionHandler)handler {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *imagePath = self.imagePath;
    if ([manager fileExistsAtPath:imagePath]) {
        [super performImageLoadingWithCompletionHandler:handler];
        if (self.image) {
            return;
        }
        
        [manager removeItemAtPath:imagePath error:nil];
    }
    
    void  (^completionHandler)(NSURL *, NSURLResponse *, NSError *) =
            ^(NSURL *location, NSURLResponse *response, NSError *error) {
                [manager moveItemAtPath:location.path toPath:imagePath error:nil];
                
                [super performImageLoadingWithCompletionHandler:handler];
            };
    
    
    NSURLSessionDownloadTask *loadingTask = [self.session downloadTaskWithURL:self.url
                                                            completionHandler:completionHandler];
    
    self.imageLoadingTask = loadingTask;
}

@end
