//
//  AMPDBUserPicture+CoreDataProperties.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDBUserPicture+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AMPDBUserPicture (CoreDataProperties)

+ (NSFetchRequest<AMPDBUserPicture *> *)fetchRequest;

@property (nonatomic, copy)     NSString    *urlString;
@property (nonatomic, assign)   NSUInteger  type;
@property (nonatomic, retain)   AMPDBUser   *user;

@end

NS_ASSUME_NONNULL_END
