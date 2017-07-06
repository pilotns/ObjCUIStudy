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

#import "NSFileManager+AMPExtensions.h"

@interface AMPImageModel ()
@property (nonatomic, strong)   NSURL   *url;

@end

@implementation AMPImageModel

@dynamic image;
@dynamic imagePath;
@dynamic imageName;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageModelWithURL:(NSURL *)url {
    AMPImageModel *imageModel = nil;
    AMPImageModelCache *modelCache = [AMPImageModelCache sharedCache];
    imageModel = [modelCache imageModelForURL:url];
    if (!imageModel) {
        Class imageModelClass = url.isFileURL
                                ? [AMPFileSystemImageModel class]
                                : [AMPInternetImageModel class];
        
        imageModel = [[imageModelClass alloc] initWithURL:url];
        [modelCache addImageModel:imageModel];
    }
    
    return imageModel;
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)processLoading {
    [self processLoadingImage];
}

- (void)processLoadingImage {
    
}

@end
