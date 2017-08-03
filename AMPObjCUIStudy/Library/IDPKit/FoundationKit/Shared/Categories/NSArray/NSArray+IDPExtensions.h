//
//  NSArray+IDPExtensions.h
//  Accomplist
//
//  Created by Oleksa 'trimm' Korin on 4/14/13.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (IDPExtensions)

/**
 This method returns a random object from this array.
 @return Random object from this array.
 */
- (id)randomObject;

/**
 This method shuffle array.
 @return a new shuffled array.
 */
- (NSArray *)shuffledArray;

@end
