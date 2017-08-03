//
//  AMPDBUser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDBUser.h"

@implementation AMPDBUser

@dynamic userID;
@dynamic firstName;
@dynamic lastName;
@dynamic fullName;
@dynamic friends;
@dynamic pictures;

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

#pragma mark -
#pragma mark Public Methods

- (void)addFriend:(AMPDBUser *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(friends))];
}

- (void)removeFriend:(AMPDBUser *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(friends))];
}

- (void)addPicture:(AMPDBUserPicture *)value {
    [self addCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(pictures))];
}

- (void)removePicture:(AMPDBUserPicture *)value {
    [self removeCustomValue:value inMutableSetForKey:NSStringFromSelector(@selector(pictures))];
}

@end
