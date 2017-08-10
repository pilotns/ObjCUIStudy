//
//  AMPDBUser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 08.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPManagedObject.h"

@interface AMPDBUser : AMPManagedObject
@property (nonatomic, copy) NSString    *userID;

+ (instancetype)managedObjectWithUserID:(NSString *)userID;

@end
