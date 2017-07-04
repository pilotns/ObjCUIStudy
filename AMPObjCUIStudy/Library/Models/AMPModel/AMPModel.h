//
//  AMPModel.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

typedef NS_ENUM(NSUInteger, AMPModelState) {
    AMPModelDidUnload,
    AMPModelWillLoad,
    AMPModelDidLoad,
    AMPModelDidFailLoading,
    AMPModelStateCount
};

@class AMPModel;

@protocol AMPModelObserver <NSObject>

@optional
- (void)modelDidUnload:(id)model;
- (void)modelWillLoad:(id)model;
- (void)modelDidLoad:(id)model;
- (void)modelDidFailLoading:(id)model;

@end

@interface AMPModel : AMPObservableObject

- (void)load;

// this methods is intended for subclassing, do not call it directly
- (void)processLoading;

@end
