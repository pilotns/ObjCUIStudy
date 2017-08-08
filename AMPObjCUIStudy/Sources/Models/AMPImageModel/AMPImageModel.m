//
//  AMPImageModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPImageModel.h"

#import "AMPFileSystemImageModel.h"
#import "AMPInternetImageModel.h"

#import "AMPImageModelCache.h"
#import "AMPMacro.h"

#import "NSFileManager+AMPExtensions.h"

@interface AMPImageModel ()
@property (nonatomic, strong)   UIImage *image;
@property (nonatomic, strong)   NSURL   *url;

@end

@implementation AMPImageModel

@dynamic imagePath;
@dynamic imageName;
@dynamic imageCache;

#pragma mark -
#pragma mark Class Methods

+ (AMPImageModelCache *)imageCache {
    return [AMPImageModelCache sharedCache];
}

+ (instancetype)imageModelWithURL:(NSURL *)url {
    AMPImageModel *imageModel = nil;
    AMPImageModelCache *modelCache = [self imageCache];
    imageModel = [modelCache imageModelForURL:url];
    if (imageModel) {
        return imageModel;
    }
    
    Class imageModelClass = url.isFileURL ? [AMPFileSystemImageModel class] : [AMPInternetImageModel class];
    
    imageModel = [[imageModelClass alloc] initWithURL:url];
    [modelCache addImageModel:imageModel];
    
    return imageModel;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[self imageCache] removeImageModel:self];
}

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)imageName {
    return [[NSFileManager defaultManager] fileNameWithURL:self.url];
}

- (AMPImageModelCache *)imageCache {
    return [[self class] imageCache];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    AMPWeakify(self)
    [self performImageLoadingWithCompletionHandler:^(UIImage *image) {
        AMPStrongifyAndReturnIfNil(self)
        self.image = image;
        self.state = image ? AMPModelDidLoad : AMPModelDidFailLoading;
    }];
}

- (void)performImageLoadingWithCompletionHandler:(AMPImageModelLoadingCompletionHandler)handler {
    
}

@end
