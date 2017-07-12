//
//  AMPFBGetContext.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPContext.h"

@interface AMPFBGetContext : AMPContext

- (instancetype)initWithModel:(id)model
                    graphPath:(NSString *)graphPath
                   parameters:(NSDictionary *)parameters;

// this methid is intended for subclassing, do not call it directly
- (void)handleResponse:(id)response;

@end
