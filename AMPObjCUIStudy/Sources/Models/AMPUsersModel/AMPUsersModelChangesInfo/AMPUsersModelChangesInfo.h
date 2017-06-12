//
//  AMPUsersModelChangesInfo.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AMPUsersModel.h"

@interface AMPUsersModelChangesInfo : NSObject
@property (nonatomic, readonly) NSArray                     *indexPaths;
@property (nonatomic, readonly) AMPUsersModelChangesType    type;

+ (instancetype)changesInfoWithIndexPath:(NSIndexPath *)indexPath type:(AMPUsersModelChangesType)type;

- (instancetype)initWithIndexPath:(NSIndexPath *)indexPath type:(AMPUsersModelChangesType)type;

@end
