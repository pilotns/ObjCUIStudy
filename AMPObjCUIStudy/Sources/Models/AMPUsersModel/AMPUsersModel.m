//
//  AMPUsersModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUsersModel.h"

#import "AMPUser.h"

#import "NSArray+AMPExtensions.h"
#import "NSIndexPath+AMPExtensions.h"
#import "AMPUsersModelChangesInfo.h"

static const NSUInteger AMPDefaultUsersCount = 5;

@interface AMPUsersModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableUsers;

@end

@implementation AMPUsersModel

@dynamic count;
@dynamic title;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.mutableUsers = [NSMutableArray objectsWithCount:AMPDefaultUsersCount factoryBlock:^id{
        return [AMPUser new];
    }];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.mutableUsers.count;
}

- (NSString *)title {
    return @"Users";
}

#pragma mark - 
#pragma mark Public Methods

- (void)addUser:(AMPUser *)user {
    [self insertUser:user atIndex:self.count];
}

- (void)addUsers:(id<NSFastEnumeration>)users {
    for (id user in users) {
        [self addUser:user];
    }
}

- (void)insertUser:(AMPUser *)user atIndex:(NSUInteger)index {
    if (user && index <= self.count) {
        [self.mutableUsers insertObject:user atIndex:index];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index];
        AMPUsersModelChangesInfo *info = [AMPUsersModelChangesInfo changesInfoWithIndexPath:indexPath
                                                                                       type:AMPUsersModelChangesTypeAdd];
        
        [self setState:AMPUsersModelChangesTypeAdd userInfo:info];
    }
}

- (void)removeUser:(AMPUser *)user {
    NSUInteger index = [self indexOfUser:user];
    if (index == NSNotFound) {
        return;
    }
    
    [self removeUserAtIndex:index];
}

- (void)removeUsers:(id<NSFastEnumeration>)users {
    for (id user in users) {
        [self removeUser:user];
    }
}

- (void)removeUserAtIndex:(NSUInteger)index {
    if (index <= self.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index];
        AMPUsersModelChangesInfo *info = [AMPUsersModelChangesInfo changesInfoWithIndexPath:indexPath
                                                                                       type:AMPUsersModelChangesTypeRemove];
        
        [self.mutableUsers removeObjectAtIndex:index];
        
        [self setState:AMPUsersModelChangesTypeRemove userInfo:info];
    }
}

- (void)moveUserAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    AMPUser *user = [self userAtIndex:sourceIndex];
    [self.mutableUsers removeObjectAtIndex:sourceIndex];
    [self.mutableUsers insertObject:user atIndex:destinationIndex];
}

- (AMPUser *)userAtIndex:(NSUInteger)index {
    if (index <= self.count) {
        return [self.mutableUsers objectAtIndex:index];
    }
    
    return nil;
}

- (AMPUser *)objectAtIndexedSubscript:(NSUInteger)index {
    return [self userAtIndex:index];
}

- (NSUInteger)indexOfUser:(AMPUser *)user {
    return [self.mutableUsers indexOfObject:user];
}

#pragma mark -
#pragma mark AMPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    return @selector(usersModel:didChangeStateWithInfo:);
}

@end
