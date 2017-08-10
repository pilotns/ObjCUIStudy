//
//  AMPFBGetContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBGetContext.h"

#import "AMPModel.h"
#import "AMPFBUser.h"

#import "AMPMacro.h"

#import "NSFileManager+AMPExtensions.h"

@interface AMPFBGetContext ()
@property (nonatomic, strong)   FBSDKGraphRequestConnection   *requestConnection;

@end

@implementation AMPFBGetContext

@dynamic graphPath;
@dynamic parameters;

#pragma mark -
#pragma mark Accessors

- (NSString *)graphPath {
    return self.user.userID;
}

- (void)setRequestConnection:(FBSDKGraphRequestConnection *)requestConnection {
    if (_requestConnection != requestConnection) {
        [_requestConnection cancel];
        
        _requestConnection = requestConnection;
        [requestConnection start];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)execute {
    AMPModel *model = self.model;
    AMPModelState state = model.state;
    @synchronized (self) {
        if (AMPModelDidLoad == state || AMPModelWillLoad == state) {
            [model notifyOfState:state];
            return;
        }
        
        model.state = AMPModelWillLoad;
    }
    
    [super execute];
}

- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler {
    FBSDKGraphRequestConnection *requestConnection = [FBSDKGraphRequestConnection new];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.graphPath
                                                                   parameters:self.parameters];
    
    AMPWeakify(self);
    [requestConnection addRequest:request
                completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    AMPStrongifyAndReturnIfNil(self);
                    [self parseResponse:result];
                    
                    if (completionHandler) {
                        completionHandler(result ? AMPModelDidLoad : AMPModelDidFailLoading, error);
                    }
                }];
    
    self.requestConnection = requestConnection;
}

- (void)cancel {
    self.requestConnection = nil;
}

- (void)parseResponse:(id)response {
    
}

@end
