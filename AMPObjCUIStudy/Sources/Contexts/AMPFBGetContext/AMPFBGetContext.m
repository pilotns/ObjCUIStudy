//
//  AMPFBGetContext.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 12.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPFBGetContext.h"

#import "AMPMacro.h"

#import "NSFileManager+AMPExtensions.h"

@interface AMPFBGetContext ()
@property (nonatomic, copy)     NSString        *graphPath;
@property (nonatomic, strong)   NSDictionary    *parameters;

@property (nonatomic, readonly) NSDictionary    *cachedResponse;
@property (nonatomic, readonly) NSString        *cachedResponsePath;

@property (nonatomic, strong)   FBSDKGraphRequestConnection   *requestConnection;

@end

@implementation AMPFBGetContext

@dynamic cachedResponseFileName;

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    [self cancel];
}

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

- (void)performExecutionWithCompletionHandler:(void (^)(NSError *))completionHandler {
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

- (void)handleResponse:(id)response {
    
}

- (void)saveResponse:(id)response {
    [NSKeyedArchiver archiveRootObject:response toFile:self.cachedResponsePath];
}

@end
