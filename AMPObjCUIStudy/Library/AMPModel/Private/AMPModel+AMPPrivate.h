//
//  AMPModel+AMPPrivate.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPModel.h"

@interface AMPModel (AMPPrivate)

- (void)loadInBackground;
- (void)saveCurrentState;

@end
