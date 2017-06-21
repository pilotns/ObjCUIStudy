//
//  AMPUser.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 11.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPUser.h"

#import "NSString+AMPRandom.h"

static NSString * const kAMPUserFirstName = @"kAMPUserFirstName";
static NSString * const kAMPUserLastName = @"kAMPUserLastName";

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
#pragma mark NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    self.firstName = [aDecoder decodeObjectForKey:kAMPUserFirstName];
    self.lastName = [aDecoder decodeObjectForKey:kAMPUserLastName];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstName forKey:kAMPUserFirstName];
    [aCoder encodeObject:self.lastName forKey:kAMPUserLastName];
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
