//
//  AMPModel.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

typedef NS_ENUM(NSUInteger, AMPModelState) {
    AMPModelUnload,
    AMPModelLoading,
    AMPModelLoaded,
    AMPModelFailLoaded
};

@class AMPModel;

@protocol AMPModelObserver <NSObject>

@optional
- (void)modelDidBecomeLoading:(AMPModel *)model;
- (void)modelDidFinishLoading:(AMPModel *)model;
- (void)modelDidFailLoading:(AMPModel *)model;

@end

@interface AMPModel : AMPObservableObject

@property (nonatomic, readonly, getter=isLoaded)    BOOL    loaded;

- (void)load;
- (void)save;
- (void)dump;

@end
