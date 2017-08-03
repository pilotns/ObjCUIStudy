//
//  AMPDBUser+CoreDataProperties.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDBUser+CoreDataProperties.h"

@implementation AMPDBUser (CoreDataProperties)

+ (NSFetchRequest<AMPDBUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AMPDBUser"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic userID;
@dynamic friends;
@dynamic pictures;

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
