//
//  AMPDBUserPicture+CoreDataProperties.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDBUserPicture+CoreDataProperties.h"

@implementation AMPDBUserPicture (CoreDataProperties)

+ (NSFetchRequest<AMPDBUserPicture *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AMPDBUserPicture"];
}

@dynamic urlString;
@dynamic type;
@dynamic user;

@end
