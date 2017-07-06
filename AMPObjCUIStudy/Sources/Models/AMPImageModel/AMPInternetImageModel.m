//
//  AMPInternetImageModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPInternetImageModel.h"

#import "NSFileManager+AMPExtensions.h"

@interface AMPInternetImageModel () <NSURLSessionDataDelegate>
@property (nonatomic, strong)       UIImage         *image;
@property (nonatomic, readonly)     NSURLSession    *session;

@property (nonatomic, strong)       NSURLSessionDataTask    *imageLoadingTask;

@end

@implementation AMPInternetImageModel

@synthesize image = _image;

#pragma mark -
#pragma mark Accessros

- (NSURLSession *)session {
    __block NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                delegate:self
                                           delegateQueue:[NSOperationQueue new]];
    });
    
    return session;
}

- (NSString *)imagePath {
    return [[[NSFileManager defaultManager] URLForDirectoryInLibraryDirectory:@"Images"]
                                            URLByAppendingPathComponent:self.imageName].path;
}

- (void)setImageLoadingTask:(NSURLSessionDataTask *)imageLoadingTask {
    if (_imageLoadingTask != imageLoadingTask) {
        [_imageLoadingTask cancel];
        
        _imageLoadingTask = imageLoadingTask;
        [imageLoadingTask resume];
    }
}

- (void)processLoadingImage {
    self.imageLoadingTask = [self.session dataTaskWithURL:self.url];
}

#pragma mark -
#pragma mark NSURLSessionDataDelegate

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSDictionary *imageAttributes = [manager attributesOfItemAtPath:self.imagePath
                                                              error:nil];
    
    if (response.expectedContentLength == [imageAttributes[NSFileSize] longLongValue]) {
        completionHandler(NSURLSessionResponseCancel);
        [super processLoadingImage];
    } else {
        [manager removeItemAtPath:self.imagePath error:nil];
        completionHandler(NSURLSessionResponseAllow);
    }
}

- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    NSError *error = dataTask.error;
    if (error) {
        [self setState:AMPModelDidFailLoading userInfo:error];
    } else {
        self.image = [UIImage imageWithData:data];
        self.state = AMPModelDidLoad;
        
        [data writeToFile:self.imagePath atomically:NO];
    }
}

@end
