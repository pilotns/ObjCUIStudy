//
//  AMPFBUser.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 03.08.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPDBUser.h"

#import "AMPFBFriends.h"

@class AMPFBUserPicture;

@interface AMPFBUser : AMPDBUser
@property (nonatomic, copy)     NSString    *userID;

@property (nonatomic, copy)     NSString    *firstName;
@property (nonatomic, copy)     NSString    *lastName;
@property (nonatomic, readonly) NSString    *fullName;
@property (nonatomic, strong)   NSSet       *friends;

@property (nonatomic, strong)   NSSet               *pictures;
@property (nonatomic, strong)   AMPFBUserPicture    *smallPicture;
@property (nonatomic, strong)   AMPFBUserPicture    *largePicture;

@property (nonatomic, readonly) AMPFBFriends        *friendsModel;

@property (nonatomic, readonly, getter=isAuthorized)    BOOL    authorized;

@end

@interface AMPFBUser (CoreDataGeneratedAccessors)

- (void)addFriend:(AMPFBUser *)value;
- (void)removeFriend:(AMPFBUser *)value;
- (void)addFriends:(NSSet *)value;
- (void)removeFriends:(NSSet *)value;

- (void)addPicture:(AMPFBUserPicture *)value;
- (void)removePicture:(AMPFBUserPicture *)value;
- (void)addPictures:(NSSet *)value;
- (void)removePictures:(NSSet *)value;

@end
