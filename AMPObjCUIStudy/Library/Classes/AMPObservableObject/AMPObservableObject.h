//
//  AMPObservableObject.h
//  AMPObjCStudy
//
//  Created by pilotns on 25.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMPObservableObject : NSObject
@property (nonatomic, assign)   NSUInteger  state;
@property (nonatomic, readonly) NSSet       *listeners;

- (void)addListener:(id)listener;
- (void)removeListener:(id)listener;
- (BOOL)isListener:(id)listener;

- (void)setState:(NSUInteger)state userInfo:(id)userInfo;

- (void)notifyOfState:(NSUInteger)state;
- (void)notifyOfState:(NSUInteger)state userInfo:(id)userInfo;

- (void)performBlockWithNotifications:(void (^)(void))block;
- (void)performBlockWithoutNotifications:(void (^)(void))block;

// This method is intended for subclassing, do not call it directly
- (SEL)selectorForState:(NSUInteger)state;

@end
