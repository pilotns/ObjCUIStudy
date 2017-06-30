//
//  AMPImageModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPImageModel.h"

@interface AMPImageModel ()
@property (nonatomic, strong)   NSURL   *url;
@property (nonatomic, strong)   UIImage *image;

@end

@implementation AMPImageModel

#pragma mark -
#pragma mark Class Methods

+ (instancetype)imageModelWithURL:(NSURL *)url {
    return [[self alloc] initWithURL:url];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithURL:(NSURL *)url {
    self = [super init];
    self.url = url;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)propertyKeyPath {
    return @"image";
}

#pragma mark -
#pragma mark Public Methods

- (void)processLoading {
    self.image = [UIImage imageWithContentsOfFile:self.url.path];
}

@end
