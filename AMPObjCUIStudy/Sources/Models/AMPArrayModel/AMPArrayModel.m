//
//  AMPArrayModel.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModel.h"

#import "AMPUser.h"
#import "AMPArrayModelChange.h"
#import "AMPMarcos.h"

#import "AMPModel+AMPPrivate.h"
#import "NSObject+AMPExtensions.h"
#import "NSIndexPath+AMPExtensions.h"
#import "AMPObservableObject+AMPPrivate.h"
#import "NSNotificationCenter+AMPExtensions.h"

typedef void(^AMPVoidBlock)(void);

@interface AMPArrayModel ()
@property (nonatomic, strong)   NSMutableArray  *mutableObjects;
@property (nonatomic, strong)   NSArray         *notificationTokens;

@property (nonatomic, readonly) NSString        *mutableObjectsPath;

- (void)performChangeWithModelChange:(AMPArrayModelChange *)modelChange block:(AMPVoidBlock)block;
- (void)prepareObserving;

@end

@implementation AMPArrayModel

@dynamic count;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObservers:self.notificationTokens];
}

- (instancetype)init {
    self = [super init];
    [self prepareObserving];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSUInteger)count {
    return self.mutableObjects.count;
}

- (BOOL)isLoaded {
    return nil != self.mutableObjects;
}

- (NSString *)mutableObjectsPath {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *url = [[manager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    
    return [url URLByAppendingPathComponent:@"users.plist"].path;
}

#pragma mark - 
#pragma mark Public Methods

- (void)addObject:(id)object {
    [self insertObject:object atIndex:self.count];
}

- (void)addObjects:(id<NSFastEnumeration>)objects {
    for (id object in objects) {
        [self addObjects:object];
    }
}

- (void)insertObject:(id)object atIndex:(NSUInteger)index {
    if (object && index <= self.count) {
        AMPArrayModelChange *modelChange = [AMPArrayModelChange arrayModelChangeInsertWithIndex:index];
        
        [self performChangeWithModelChange:modelChange block:^{
            [self.mutableObjects insertObject:object atIndex:index];
        }];
    }
}

- (void)removeObject:(id)object {
    NSUInteger index = [self indexOfObject:object];
    if (index == NSNotFound) {
        return;
    }
    
    [self removeObjectAtIndex:index];
}

- (void)removeObjects:(id<NSFastEnumeration>)objects {
    for (id object in objects) {
        [self removeObject:object];
    }
}

- (void)removeObjectAtIndex:(NSUInteger)index {
    if (index < self.count) {
        AMPArrayModelChange *modelChange = [AMPArrayModelChange arrayModelChangeDeleteWithIndex:index];
        
        [self performChangeWithModelChange:modelChange block:^{
            [self.mutableObjects removeObjectAtIndex:index];
        }];
    }
}

- (void)moveObjectAtIndex:(NSUInteger)sourceIndex toIndex:(NSUInteger)destinationIndex {
    if (sourceIndex == destinationIndex) {
        return;
    }
    
    AMPArrayModelChange *modelChange = [AMPArrayModelChange arrayModelChangeMoveWithSourceIndex:sourceIndex
                                                                               destinationIndex:destinationIndex];
    id object = [self objectAtIndex:sourceIndex];
    [self performChangeWithModelChange:modelChange block:^{
        [self.mutableObjects removeObjectAtIndex:sourceIndex];
        [self.mutableObjects insertObject:object atIndex:destinationIndex];
    }];
}

- (id)objectAtIndex:(NSUInteger)index {
    return index < self.count ? self.mutableObjects[index] : nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)index {
    return [self objectAtIndex:index];
}

- (NSUInteger)indexOfObject:(id)object {
    return [self.mutableObjects indexOfObject:object];
}

#pragma mark -
#pragma mark Override Methods

- (void)processLoad {
    NSMutableArray *users = [NSKeyedUnarchiver unarchiveObjectWithFile:self.mutableObjectsPath];;
    
    if (!users) {
        users = [NSMutableArray array];
    }
    
    usleep(1000 * 1000 * 3);
    self.mutableObjects = users;
}

- (void)processSave {
    [NSKeyedArchiver archiveRootObject:self.mutableObjects toFile:self.mutableObjectsPath];
}

- (void)processDump {
    [self save];
    self.mutableObjects = nil;
}

#pragma mark -
#pragma mark Private Metohds

- (void)performChangeWithModelChange:(AMPArrayModelChange *)modelChange block:(AMPVoidBlock)block {
    if (!block) {
        return;
    }
    
    block();
    
    [self notifyOfStateWithSelector:@selector(arrayModel:didChangeWithArrayModelChange:)
                           userInfo:modelChange];
}

- (void)prepareObserving {
    NSArray *notificationNames = @[UIApplicationWillTerminateNotification,
                                  UIApplicationWillResignActiveNotification];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    AMPWeakify(self);
    self.notificationTokens = [center addObserverForNames:notificationNames usingBlock:^(NSNotification *note) {
        AMPStrongifyAndReturnIfNil(self);
        [self save];
    }];
}

@end
