//
//  AMPDBUser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 08.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDBUser.h"

@implementation AMPDBUser

@dynamic userID;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)managedObjectWithUserID:(NSString *)userID {
    return [self managedObjectWithValue:userID forKeyPath:NSStringFromSelector(@selector(userID))];
}

@end
