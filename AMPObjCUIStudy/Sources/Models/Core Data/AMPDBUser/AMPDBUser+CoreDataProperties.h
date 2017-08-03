//
//  AMPDBUser+CoreDataProperties.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDBUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AMPDBUser (CoreDataProperties)

+ (NSFetchRequest<AMPDBUser *> *)fetchRequest;

@property (nullable, nonatomic, copy)   NSString                    *firstName;
@property (nullable, nonatomic, copy)   NSString                    *lastName;
@property (nullable, nonatomic, copy)   NSString                    *userID;
@property (nullable, nonatomic, retain) NSSet<AMPDBUser *>          *friends;
@property (nullable, nonatomic, retain) NSSet<AMPDBUserPicture *>   *pictures;

@end

@interface AMPDBUser (CoreDataGeneratedAccessors)

- (void)addFriend:(AMPDBUser *)value;
- (void)removeFriend:(AMPDBUser *)value;
- (void)addFriends:(NSSet<AMPDBUser *> *)values;
- (void)removeFriends:(NSSet<AMPDBUser *> *)values;

- (void)addPicture:(AMPDBUserPicture *)value;
- (void)removePicture:(AMPDBUserPicture *)value;
- (void)addPictures:(NSSet<AMPDBUserPicture *> *)values;
- (void)removePictures:(NSSet<AMPDBUserPicture *> *)values;

@end

NS_ASSUME_NONNULL_END
