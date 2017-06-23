//
//  AMPImageModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPImageModel.h"

#import "AMPModel+AMPPrivate.h"

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
#pragma mark Override Methods

- (BOOL)isLoaded {
    return nil != self.image;
}

- (void)processLoad {
    UIImage *image = [UIImage imageWithContentsOfFile:self.url.path];
    usleep(1000 * 100);
    self.image = image;
}

- (void)processSave {
    
}

- (void)processDump {
    self.image = nil;
}

@end
