//
//  AMPUsersModelChangesInfo.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUsersModelChangesInfo.h"

@interface AMPUsersModelChangesInfo ()
@property (nonatomic, strong) NSIndexPath               *indexPath;
@property (nonatomic, assign) AMPUsersModelChangesType  type;

@end

@implementation AMPUsersModelChangesInfo

@dynamic indexPaths;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)changesInfoWithIndexPath:(NSIndexPath *)indexPath type:(AMPUsersModelChangesType)type {
    return [[self alloc] initWithIndexPath:indexPath type:type];
}

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath type:(AMPUsersModelChangesType)type {
    self = [super init];
    self.indexPath = indexPath;
    self.type = type;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)indexPaths {
    return @[self.indexPath];
}

@end
