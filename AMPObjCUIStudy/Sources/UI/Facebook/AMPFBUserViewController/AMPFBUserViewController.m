//
//  AMPFBUserViewController.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBUserViewController.h"

#import "AMPGCDExtensions.h"
#import "AMPFBGetUserContext.h"
#import "AMPFBUserView.h"
#import "AMPFBUser.h"
#import "AMPFBViewController.h"

#import "AMPFBGetUsersContext.h"
#import "AMPFBUsersViewController.h"

#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBUserViewController, AMPFBUserView, userView);

@interface AMPFBUserViewController ()
@property (nonatomic, readonly) AMPFBUser *user;

@end

@implementation AMPFBUserViewController

#pragma mark -
#pragma mark - Accessors

- (AMPFBUser *)user {
    return (AMPFBUser *)self.model;
}

#pragma mark -
#pragma mark Public Methods

- (void)fillWithModel:(id)model {
    self.navigationItem.title = self.user.fullName;
    [self.userView fillWithUser:model];
}

#pragma mark -
#pragma mark View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    AMPFBUser *user = self.user;
    NSDictionary *parameters = @{@"fields" : @"first_name,last_name,picture.type(large)"};
    self.context = [[AMPFBGetUserContext alloc] initWithModel:user
                                                    graphPath:user.fbUserID
                                                   parameters:parameters];
}

@end
