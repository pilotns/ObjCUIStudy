//
//  AMPArrayModelChangeMove.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChangeMove.h"

#import "AMPArrayModelChange+AMPPrivate.h"

#import "NSIndexPath+AMPExtensions.h"

@interface AMPArrayModelChangeMove ()
@property (nonatomic, strong)   NSIndexPath *sourceIndexPath;
@property (nonatomic, strong)   NSIndexPath *destinationIndexPath;

@end

@implementation AMPArrayModelChangeMove

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex
                   destinationIndex:(NSUInteger)destinationIndex
{
    return [self initWithSourceIndexPath:[NSIndexPath indexPathForRow:sourceIndex]
                    destinationIndexPath:[NSIndexPath indexPathForRow:destinationIndex]];
}

- (instancetype)initWithSourceIndexPath:(NSIndexPath *)sourceIndexPath
                   destinationIndexPath:(NSIndexPath *)destinationIndexPath
{
    self = [super init];
    self.sourceIndexPath = sourceIndexPath;
    self.destinationIndexPath = destinationIndexPath;
    
    return self;
}

#pragma mark -
#pragma mark Public Methods

- (void)applyToTableView:(UITableView *)tableView withRowAnimation:(UITableViewRowAnimation)animation {
    [tableView moveRowAtIndexPath:self.sourceIndexPath toIndexPath:self.destinationIndexPath];
}

@end
