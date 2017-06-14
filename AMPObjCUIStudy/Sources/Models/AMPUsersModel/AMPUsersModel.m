//
//  AMPUsersModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUsersModel.h"

#import "AMPUser.h"

#import "NSObject+AMPExtensions.h"
#import "NSIndexPath+AMPExtensions.h"

typedef void(^AMPVoidBlock)(void);

void (^AMPPerformChangesBlock)(AMPUsersModel *, NSUInteger index, AMPUsersModelChangesType, AMPVoidBlock) =
    ^(AMPUsersModel *model, NSUInteger index, AMPUsersModelChangesType type, AMPVoidBlock block) {
        if (!block) {
            return;
        }
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index];
        block();
        
        [model setState:type userInfo:indexPath];
    };

static const NSUInteger AMPDefaultUsersCount = 10;
static NSString * const AMPUsersModelTitle = @"Users";

@interface AMPUsersModel () <NSCopying>
@property (nonatomic, strong)   NSMutableArray  *mutableUsers;

@end

@implementation AMPUsersModel

@dynamic count;
@dynamic title;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    return [self initWithUsers:[AMPUser objectsWithCount:AMPDefaultUsersCount]];
}

- (instancetype)initWithUsers:(NSArray *)users {
    self = [super init];
    self.mutableUsers = [NSMutableArray arrayWithArray:users];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.mutableUsers.count;
}

- (NSString *)title {
    return AMPUsersModelTitle;
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
        AMPPerformChangesBlock(self, index, AMPUsersModelChangesTypeAdd, ^{
            [self.mutableUsers insertObject:user atIndex:index];
        });
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
        AMPPerformChangesBlock(self, index, AMPUsersModelChangesTypeRemove, ^{
            [self.mutableUsers removeObjectAtIndex:index];
        });
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

- (void)performSorting {
    NSArray *previousModelState = [self copy];
    
    [self.mutableUsers sortUsingComparator:^NSComparisonResult(AMPUser *obj1, AMPUser *obj2) {
        return [obj1.fullName compare:obj2.fullName options:NSCaseInsensitiveSearch];
    }];
    
    [self setState:AMPUsersModelChangesTypeSorting userInfo:previousModelState];
}

#pragma mark -
#pragma mark NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained _Nullable [_Nonnull])buffer
                                    count:(NSUInteger)len
{
    return [self.mutableUsers countByEnumeratingWithState:state objects:buffer count:len];
}

#pragma mark -
#pragma mark AMPObservableObject

- (SEL)selectorForState:(NSUInteger)state {
    return @selector(usersModel:didChangeStateWithInfo:);
}

#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(nullable NSZone *)zone {
    return [[[self class] alloc] initWithUsers:self.mutableUsers];
}

@end
