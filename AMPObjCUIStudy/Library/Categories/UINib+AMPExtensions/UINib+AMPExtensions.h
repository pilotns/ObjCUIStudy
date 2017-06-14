//
//  UINib+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (AMPExtensions)

+ (instancetype)nibWithClass:(Class)class;
+ (instancetype)nibWithClass:(Class)class inBundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)class;
+ (id)objectWithClass:(Class)class inBundle:(NSBundle *)bundle;
+ (id)objectWithClass:(Class)class inBundle:(NSBundle *)bundle owner:(id)owner options:(NSDictionary *)options;

@end
