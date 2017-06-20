//
//  AMPObservableObject+AMPPrivate.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

@interface AMPObservableObject (AMPPrivate)

- (void)notifyOfStateWithSelector:(SEL)aSelector userInfo:(id)userInfo;

@end
