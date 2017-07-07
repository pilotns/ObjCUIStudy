//
//  NSFileManager+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#define AMPOnceURL(code) \
    static NSURL *url = nil; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ code }); \
    \
    return url;

#define AMPURLForDirectoryWithSearchPathAndDomain(searchPath, domain) \
    url = [self URLsForDirectory:searchPath inDomains:domain].firstObject;

#define AMPURLForDirectoryInLibraryDirectoryCreateIfNeeded(directoryName) \
    url = [[self URLForLibraryDirectory] URLByAppendingPathComponent:directoryName]; \
    if (![[NSFileManager defaultManager] createDirectoryAtPath:url.path \
                                   withIntermediateDirectories:YES \
                                                    attributes:nil \
                                                         error:nil]) { \
        url = nil; \
    }


#import "NSFileManager+AMPExtensions.h"

@implementation NSFileManager (AMPExtensions)

- (NSURL *)URLForLibraryDirectory {
    AMPOnceURL(AMPURLForDirectoryWithSearchPathAndDomain(NSLibraryDirectory, NSUserDomainMask));
}

- (NSURL *)URLForDocumentsDirectory {
    AMPOnceURL(AMPURLForDirectoryWithSearchPathAndDomain(NSDocumentDirectory, NSUserDomainMask));
}

- (NSURL *)URLForDirectoryInLibraryDirectory:(NSString *)directoryName {
    AMPOnceURL(AMPURLForDirectoryInLibraryDirectoryCreateIfNeeded(directoryName));
}

- (NSString *)fileNameWithURL:(NSURL *)url {
    if (url.isFileURL) {
        return url.lastPathComponent;
    }
    
    return [url.path stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
}

- (long long)fileSizeAtPath:(NSString *)path {
    NSDictionary *fileAttributes = [self attributesOfItemAtPath:path error:nil];
    
    return [fileAttributes[NSFileSize] longLongValue];
}

@end
