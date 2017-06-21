//
//  AMPModel+AMPPrivate.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

// subclasses must provide implementation of the following interface

@interface AMPModel (AMPPrivate)
@property (nonatomic, readonly, getter=isLoaded)    BOOL    loaded;

- (void)loadInBackground;
- (void)saveCurrentState;

@end
