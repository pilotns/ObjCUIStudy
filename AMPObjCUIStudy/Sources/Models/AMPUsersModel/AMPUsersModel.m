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

static const NSUInteger AMPDefaultUsersCount = 500;

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
    if (user) {
        [self.mutableUsers addObject:user];
    }
}

- (void)addUsers:(id<NSFastEnumeration>)users {
    for (id user in users) {
        [self addUser:user];
    }
}

- (void)insertUser:(AMPUser *)user atIndex:(NSUInteger)index {
    if (user && index <= self.count) {
        [self.mutableUsers insertObject:user atIndex:index];
    }
}

- (void)removeUser:(AMPUser *)user {
    [self.mutableUsers removeObject:user];
}

- (void)removeUsers:(id<NSFastEnumeration>)users {
    for (id user in users) {
        [self removeUser:user];
    }
}

- (void)removeUserAtIndex:(NSUInteger)index {
    if (index <= self.count) {
        [self.mutableUsers removeObjectAtIndex:index];
    }
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

@end
