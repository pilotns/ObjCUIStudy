//
//  AMPManagedObject.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 08.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPManagedObject.h"

@interface AMPManagedObject ()
@property(nonatomic, strong)    id  model;

@end

@implementation AMPManagedObject

@synthesize model = _model;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)managedObjectWithValue:(id)value forKeyPath:(NSString *)keyPath {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %@", keyPath, value];
    
    AMPManagedObject *managedObject = [[self fetchEntityWithSortDescriptors:nil
                                                                  predicate:predicate
                                                              prefetchPaths:nil] firstObject];
    
    if (!managedObject) {
        managedObject = [self managedObject];
        [managedObject setCustomValue:value forKey:keyPath];
    }
    
    return managedObject;
}

#pragma mark -
#pragma makr Initializations and Deallocations

- (__kindof NSManagedObject *)initWithEntity:(NSEntityDescription *)entity
             insertIntoManagedObjectContext:(NSManagedObjectContext *)context
{
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    self.model = [AMPModel modelWithTarget:self];
    
    return self;
}

#pragma mark -
#pragma mark Override Methods

- (void)save {
    [self saveManagedObject];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    id model = self.model;
    
    return [model respondsToSelector:aSelector] ? model : [super forwardingTargetForSelector:aSelector];
}

@end
