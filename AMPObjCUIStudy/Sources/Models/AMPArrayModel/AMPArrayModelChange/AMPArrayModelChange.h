//
//  AMPArrayModelChange.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMPArrayModelChange : NSObject
@property (nonatomic, readonly) NSIndexPath *indexPath;

+ (instancetype)arrayModelChangeInsertWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelChangeDeleteWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelChangeMoveWithSourceIndex:(NSUInteger)sourceIndex
                                   destinationIndex:(NSUInteger)destinationIndex;

+ (instancetype)arrayModelChangeInsertWithIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)arrayModelChangeDeleteWithIndexPath:(NSIndexPath *)indexPath;
+ (instancetype)arrayModelChangeMoveWithSourceIndexPath:(NSIndexPath *)sourceIndexPath
                                   destinationIndexPath:(NSIndexPath *)destinationIndexPath;

- (instancetype)initWithIndex:(NSUInteger)index;
- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath;

- (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex
                   destinationIndex:(NSUInteger)destinationIndex;

- (instancetype)initWithSourceIndexPath:(NSIndexPath *)sourceIndexPath
                   destinationIndexPath:(NSIndexPath *)destinationIndexPath;

@end
