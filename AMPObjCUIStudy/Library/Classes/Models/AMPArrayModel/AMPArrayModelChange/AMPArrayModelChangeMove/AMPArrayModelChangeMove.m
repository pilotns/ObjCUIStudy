//
//  AMPArrayModelChangeMove.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 19.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPArrayModelChangeMove.h"

#import "NSIndexPath+AMPExtensions.h"
#import "AMPArrayModelChange+UITableView.h"

@interface AMPArrayModelChangeMove ()
@property (nonatomic, assign)   NSUInteger sourceIndex;
@property (nonatomic, assign)   NSUInteger destinationIndex;

@end

@implementation AMPArrayModelChangeMove

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithSourceIndex:(NSUInteger)sourceIndex
                   destinationIndex:(NSUInteger)destinationIndex
{
    self = [super init];
    self.sourceIndex = sourceIndex;
    self.destinationIndex = destinationIndex;
    
    return self;
}

#pragma mark -
#pragma mark AMPArrayModelChange (UITableView)

- (void)applyToTableView:(UITableView *)tableView
                 section:(NSUInteger)section
            rowAnimation:(UITableViewRowAnimation)animation
{
    NSIndexPath *sourceIndexPath = [NSIndexPath indexPathForRow:self.sourceIndex inSection:section];
    NSIndexPath *destinationIndexPath = [NSIndexPath indexPathForRow:self.destinationIndex inSection:section];
    
    [tableView moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

@end
