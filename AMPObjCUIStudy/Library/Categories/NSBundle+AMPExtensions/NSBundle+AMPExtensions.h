//
//  NSBundle+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSBundle (AMPExtensions)

- (id)objectWithClass:(Class)class;
- (id)objectWithClass:(Class)class owner:(id)owner options:(NSDictionary *)options;

@end
