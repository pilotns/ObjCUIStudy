//
//  IDPObserver.h
//  iOS
//
//  Created by Oleksa 'trimm' Korin on 2/25/16.
//  Copyright © 2016 IDAP Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IDPObservableObject;

typedef NSUInteger IDPObjectState;
typedef void(^IDPObserverCallback)(id observableObject, id info);

@interface IDPObserver : NSObject
@property (nonatomic, weak, readonly) IDPObservableObject     *observableObject;
@property (nonatomic, readonly, getter=isValid) BOOL    valid;

- (instancetype)initWithObservableObject:(IDPObservableObject *)observableObject;

- (void)setBlock:(IDPObserverCallback)block forState:(IDPObjectState)state;
- (IDPObserverCallback)blockForState:(IDPObjectState)state;

- (id)objectAtIndexedSubscript:(NSUInteger)state;
- (void)setObject:(id)block atIndexedSubscript:(NSUInteger)state;

- (void)performBlockForState:(IDPObjectState)state object:(id)object;

@end
