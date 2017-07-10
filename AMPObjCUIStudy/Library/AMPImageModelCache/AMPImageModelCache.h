//
//  AMPImageModelCache.h
//  AMPObjCUIStudy_2
//
//  Created by pilotns on 30.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AMPImageModel;

@interface AMPImageModelCache : NSObject
@property (nonatomic, readonly) NSUInteger  count;

+ (instancetype)sharedCache;

- (void)addImageModel:(AMPImageModel *)model;
- (void)removeImageModel:(AMPImageModel *)model;

- (AMPImageModel *)imageModelForURL:(NSURL *)url;
- (AMPImageModel *)objectForKeyedSubscript:(NSURL *)url;

@end
