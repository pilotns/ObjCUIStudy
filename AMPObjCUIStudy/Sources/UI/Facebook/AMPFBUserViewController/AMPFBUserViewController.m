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

#import "AMPFBGetUsersContext.h"
#import "AMPFBUsersViewController.h"

#import "AMPMacro.h"

AMPSynthesizeBaseViewProperty(AMPFBUserViewController, AMPFBUserView, userView);

@interface AMPFBUserViewController ()
@property (nonatomic, strong)   AMPFBGetUserContext *context;

@end

@implementation AMPFBUserViewController

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)init {
    self = [super init];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setUser:(AMPFBUser *)user {
    if (_user != user) {
        [_user removeObserver:self];
        
        _user = user;
        [user addObserver:self];
    }
}

- (void)setContext:(AMPFBGetUserContext *)context {
    if (_context != context) {
        [_context cancel];
        
        _context = context;
        [context execute];
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction)onFriendsButton:(id)sender {
    AMPFBUsersViewController *usersViewController = [AMPFBUsersViewController new];
    usersViewController.user = self.user;
    
    [self.navigationController pushViewController:usersViewController animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelWillLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        [self.userView setLoadingViewVisible:YES];
    });
}

- (void)modelDidLoad:(id)model {
    AMPWeakify(self);
    AMPDispatchAsyncOnMainQueue(^{
        AMPStrongifyAndReturnIfNil(self);
        self.navigationItem.title = self.user.fullName;
        [self.userView fillWithUser:model];
        [self.userView setLoadingViewVisible:NO];
    });
}

@end
