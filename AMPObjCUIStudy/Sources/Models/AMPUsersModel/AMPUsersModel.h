//
//  AMPUsersModel.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPObservableObject.h"

typedef NS_ENUM(NSUInteger, AMPUsersModelChangesType) {
    AMPUsersModelChangesTypeAdd,
    AMPUsersModelChangesTypeRemove,
    AMPUsersModelChangesTypeExchange
};

@class AMPUsersModelChangesInfo;
@class AMPUsersModel;
@class AMPUser;

@protocol AMPUsersModelObserver <NSObject>

- (void)usersModel:(AMPUsersModel *)model didChangeStateWithInfo:(AMPUsersModelChangesInfo *)info;

@end

@interface AMPUsersModel : AMPObservableObject
@property (nonatomic, readonly) NSUInteger  count;
@property (nonatomic, readonly) NSString    *title;

- (void)addUser:(AMPUser *)user;
- (void)addUsers:(id<NSFastEnumeration>)users;
- (void)insertUser:(AMPUser *)user atIndex:(NSUInteger)index;

- (void)removeUser:(AMPUser *)user;
- (void)removeUsers:(id<NSFastEnumeration>)users;
- (void)removeUserAtIndex:(NSUInteger)index;

- (AMPUser *)userAtIndex:(NSUInteger)index;
- (AMPUser *)objectAtIndexedSubscript:(NSUInteger)index;

@end
