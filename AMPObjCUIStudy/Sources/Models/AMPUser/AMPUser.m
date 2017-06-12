//
//  AMPUser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUser.h"

#import "NSString+AMPRandom.h"

@interface AMPUser ()
@property (nonatomic, strong)   NSString    *firstName;
@property (nonatomic, strong)   NSString    *lastName;

@end

@implementation AMPUser

@dynamic fullName;
@dynamic image;

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    self.firstName = [NSString randomName];
    self.lastName = [NSString randomName];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
}

- (UIImage *)image {
    return [UIImage imageNamed:@"vw.jpg"];
}

@end
