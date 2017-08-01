//
//  AMPFBGetContext.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPContext.h"

@interface AMPFBGetContext : AMPContext
@property (nonatomic, readonly) NSString        *graphPath;
@property (nonatomic, readonly) NSDictionary    *parameters;
@property (nonatomic, readonly) NSString        *cachedResponseFileName;

- (void)saveResponse:(id)response;

// this methid is intended for subclassing, do not call it directly
- (void)parseResponse:(id)response;

@end
