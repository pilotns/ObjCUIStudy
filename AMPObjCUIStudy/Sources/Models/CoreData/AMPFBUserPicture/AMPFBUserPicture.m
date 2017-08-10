//
//  AMPFBUserPicture.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUserPicture.h"

#import "AMPImageModel.h"

@implementation AMPFBUserPicture

@dynamic type;
@dynamic urlString;
@dynamic user;

@dynamic imageModel;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)managedObjectWithURLString:(NSString *)string {
    return [self managedObjectWithValue:string forKeyPath:NSStringFromSelector(@selector(urlString))];
}

#pragma mark -
#pragma mark Accessors

- (AMPImageModel *)imageModel {
    return [AMPImageModel imageModelWithURL:[NSURL URLWithString:self.urlString]];
}

@end
