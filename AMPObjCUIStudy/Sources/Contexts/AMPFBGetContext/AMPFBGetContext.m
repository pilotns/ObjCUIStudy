//
//  AMPFBGetContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBGetContext.h"

#import "AMPMacro.h"

@interface AMPFBGetContext ()
@property (nonatomic, copy)     NSString        *graphPath;
@property (nonatomic, strong)   NSDictionary    *parameters;

@property (nonatomic, strong)   FBSDKGraphRequestConnection   *requestConnection;

@end

@implementation AMPFBGetContext

#pragma mark -
#pragma mark Initializations and Deallocations

- (instancetype)initWithModel:(id)model
                    graphPath:(NSString *)graphPath
                   parameters:(NSDictionary *)parameters
{
    self = [super initWithModel:model];
    self.graphPath = graphPath;
    self.parameters = parameters;
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setRequestConnection:(FBSDKGraphRequestConnection *)requestConnection {
    if (_requestConnection != requestConnection) {
        [_requestConnection cancel];
        
        _requestConnection = requestConnection;
        [requestConnection start];
    }
}

#pragma mark -
#pragma mark Public Methods

- (void)performExecutionWithCompletionHandler:(void (^)(NSError *))completionHandler {
    FBSDKGraphRequestConnection *requestConnection = [FBSDKGraphRequestConnection new];
    [requestConnection setDelegateQueue:[NSOperationQueue new]];
    
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:self.graphPath
                                                                   parameters:self.parameters];
    
    AMPWeakify(self);
    [requestConnection addRequest:request
                completionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                    AMPStrongifyAndReturnIfNil(self);
                    [self handleResponse:result];
                    if (completionHandler) {
                        completionHandler(error);
                    }
                }];
    
    self.requestConnection = requestConnection;
}

- (void)cancel {
    self.requestConnection = nil;
}

- (void)handleResponse:(id)request {
    
}

@end
