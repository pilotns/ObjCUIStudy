//
//  UINib+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (AMPExtensions)

+ (instancetype)nibWithClass:(Class)cls;
+ (instancetype)nibWithClass:(Class)cls bundle:(NSBundle *)bundle;

+ (id)objectWithClass:(Class)cls;
+ (id)objectWithClass:(Class)cls bundle:(NSBundle *)bundle;
+ (id)objectWithClass:(Class)cls bundle:(NSBundle *)bundle owner:(id)owner options:(NSDictionary *)options;

- (id)objectWithClass:(Class)cls;
- (id)objectWithClass:(Class)cls bundle:(NSBundle *)bundle;
- (id)objectWithClass:(Class)cls bundle:(NSBundle *)bundle owner:(id)owner options:(NSDictionary *)options;

@end
