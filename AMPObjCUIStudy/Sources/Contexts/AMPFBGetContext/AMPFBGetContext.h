//
//  AMPFBGetContext.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBContext.h"

@interface AMPFBGetContext : AMPFBContext
@property (nonatomic, readonly) NSString        *graphPath;
@property (nonatomic, readonly) NSDictionary    *parameters;

// this methid is intended for subclassing, do not call it directly
- (void)parseResponse:(id)response;

@end
