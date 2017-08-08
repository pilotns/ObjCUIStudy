//
//  AMPArrayModelChange.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AMPArrayModelChange : NSObject

+ (instancetype)arrayModelChangeInsertWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelChangeDeleteWithIndex:(NSUInteger)index;
+ (instancetype)arrayModelChangeMoveWithSourceIndex:(NSUInteger)sourceIndex
                                   destinationIndex:(NSUInteger)destinationIndex;

@end
