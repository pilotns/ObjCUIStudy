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
@property (nonatomic, readonly) AMPFBUser       *user;
@property (nonatomic, readonly) NSDictionary    *cachedResponse;
@property (nonatomic, readonly) NSString        *cachedResponsePath;

@property (nonatomic, strong)   FBSDKGraphRequestConnection   *requestConnection;

@end

@implementation AMPFBGetContext

@dynamic graphPath;
@dynamic parameters;
@dynamic cachedResponseFileName;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancel];
}

#pragma mark -
#pragma mark Accessors

- (AMPFBUser *)user {
    return self.model;
}

- (NSDictionary *)cachedResponse {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:self.cachedResponsePath];
}

- (NSString *)cachedResponsePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    
    return [[manager URLForDocumentsDirectory] URLByAppendingPathComponent:self.cachedResponseFileName].path;
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
    
    @synchronized (model) {
        if (AMPModelWillLoad == state || AMPModelDidLoad == state) {
            [model notifyOfState:state];
            if (AMPModelDidLoad == state) {
                return;
            }
        }
        
        model.state = AMPModelWillLoad;
    }
    
    [super execute];
}

- (void)performExecutionWithCompletionHandler:(AMPContextCompletionHandler)completionHandler {
    FBSDKGraphRequestConnection *requestConnection = [FBSDKGraphRequestConnection new];
    [requestConnection setDelegateQueue:[NSOperationQueue new]];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.graphPath
                                                                   parameters:self.parameters];
    
    AMPWeakify(self);
    [requestConnection addRequest:request
                completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    AMPStrongifyAndReturnIfNil(self);
                    if (!error) {
                        [self saveResponse:result];
                    } else {
                        result = self.cachedResponse;
                    }
                    
                    [self parseResponse:result];
                    AMPModelState state = !error || result ? AMPModelDidLoad : AMPModelDidFailLoading;
                    
                    if (completionHandler) {
                        completionHandler(state, error);
                    }
                }];
    
    self.requestConnection = requestConnection;
}

- (void)cancel {
    self.requestConnection = nil;
}

- (void)parseResponse:(id)response {
    
}

- (void)saveResponse:(id)response {
    [NSKeyedArchiver archiveRootObject:response toFile:self.cachedResponsePath];
}

@end
