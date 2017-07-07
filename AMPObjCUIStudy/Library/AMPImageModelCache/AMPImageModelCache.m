//
//  AMPImageModelCache.m
//  AMPObjCUIStudy_2
//
//  Created by pilotns on 30.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPImageModelCache.h"

#import "AMPImageModel.h"

#import "AMPGCDExtensions.h"

@interface AMPImageModelCache ()
@property (nonatomic, strong)   NSMapTable  *storage;

@end

@implementation AMPImageModelCache

@dynamic count;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedCache {
    static id sharedCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCache = [self new];
    });
    
    return sharedCache;
}

#pragma mark -
#pragma mark Initializationa and Deallocations

- (instancetype)init {
    self = [super init];
    self.storage = [NSMapTable strongToWeakObjectsMapTable];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    @synchronized (self) {
        return self.storage.count;
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)addImageModel:(AMPImageModel *)model {
    @synchronized (self) {
        [self.storage setObject:model forKey:model.url];
    }
}

- (void)removeImageModelForURL:(NSURL *)url {
    @synchronized (self) {
        [self.storage removeObjectForKey:url];
    }
}

- (AMPImageModel *)imageModelForURL:(NSURL *)url {
    @synchronized (self) {
        return [self.storage objectForKey:url];
    }
}

- (AMPImageModel *)objectForKeyedSubscript:(NSURL *)url {
    return [self imageModelForURL:url];
}

@end
