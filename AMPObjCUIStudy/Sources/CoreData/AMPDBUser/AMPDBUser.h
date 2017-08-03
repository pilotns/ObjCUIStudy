//
//  AMPDBUser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPDBUserPicture;

@interface AMPDBUser : NSManagedObject
@property (nonatomic, copy)     NSString    *userID;
@property (nonatomic, copy)     NSString    *firstName;
@property (nonatomic, copy)     NSString    *lastName;
@property (nonatomic, readonly) NSString    *fullName;
@property (nonatomic, strong)   NSSet       *friends;
@property (nonatomic, strong)   NSSet       *pictures;

@end

@interface AMPDBUser (CoreDataGeneratedAccessors)

- (void)addFriend:(AMPDBUser *)value;
- (void)removeFriend:(AMPDBUser *)value;
- (void)addFriends:(NSSet *)value;
- (void)removeFriends:(NSSet *)value;

- (void)addPicture:(AMPDBUserPicture *)value;
- (void)removePicture:(AMPDBUserPicture *)value;
- (void)addPictures:(NSSet *)value;
- (void)removePictures:(NSSet *)value;

@end
