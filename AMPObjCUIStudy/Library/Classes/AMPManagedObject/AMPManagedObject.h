//
//  AMPManagedObject.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 08.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "AMPModel.h"

@interface AMPManagedObject : NSManagedObject <AMPModel>

// method searches object in database with predicate format "keyPath = value",
// if object is missing, it will be created
+ (instancetype)managedObjectWithValue:(id)value forKeyPath:(NSString *)keyPath;

@end
