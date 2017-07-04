//
//  NSMutableArray+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 04.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (AMPExtensions)

- (void)moveObjectAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex;

@end
