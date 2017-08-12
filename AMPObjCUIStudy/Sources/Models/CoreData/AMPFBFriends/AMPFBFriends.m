//
//  AMPFBFriends.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 09.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <CoreData/CoreData.h>

#import "AMPFBFriends.h"

#import "AMPFBUser.h"

@interface AMPFBFriends () <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong)   AMPFBUser                   *user;
@property (nonatomic, strong)   NSFetchedResultsController  *controller;
@property (nonatomic, strong)   NSError                     *error;

@property (nonatomic, readonly) NSFetchRequest  *request;
@property (nonatomic, readonly) NSArray         *sortDescriptors;
@property (nonatomic, readonly) NSPredicate     *predicate;

@property (nonatomic, readonly) NSManagedObjectContext  *context;

- (void)prepareFetchedResultsController;

@end

@implementation AMPFBFriends

@dynamic request;
@dynamic sortDescriptors;
@dynamic predicate;

#pragma mark -
#pragma Initializations and Deallocations

- (instancetype)initWithUser:(AMPFBUser *)user {
    self = [super init];
    self.user = user;
    [self prepareFetchedResultsController];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setController:(NSFetchedResultsController *)controller {
    if (_controller != controller) {
        _controller.delegate = nil;
        
        _controller = controller;
        controller.delegate = self;
        
        NSError *error = self.error;
        [controller performFetch:&error];
    }
}

- (NSFetchRequest *)request {
    NSFetchRequest *request =  [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([self.user class])];
    request.predicate = self.predicate;
    request.sortDescriptors = self.sortDescriptors;
    
    return request;
}

- (NSArray *)sortDescriptors {
    return @[[NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(userID)) ascending:YES]];
}

- (NSPredicate *)predicate {
    return [NSPredicate predicateWithFormat:@"friends CONTAINS %@", self.user];
}

- (NSManagedObjectContext *)context {
    return [[IDPCoreDataManager sharedManager] managedObjectContext];
}

#pragma mark -
#pragma mark Public Methods

- (void)performLoading {
    [self performBlockWithoutNotifications:^{
        [self addObjects:self.controller.fetchedObjects];
    }];
}

#pragma mark -
#pragma mark Private Methods

- (void)prepareFetchedResultsController {
    self.controller = [[NSFetchedResultsController alloc] initWithFetchRequest:self.request
                                                          managedObjectContext:self.context
                                                            sectionNameKeyPath:nil
                                                                     cacheName:nil];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self addObject:anObject];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self removeObjectAtIndex:indexPath.row];
            break;
            
        case NSFetchedResultsChangeMove:
            [self moveObjectAtIndex:indexPath.row toIndex:newIndexPath.row];
            break;
            
        default:
            break;
    }
}

@end
