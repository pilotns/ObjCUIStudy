//
//  NSFileManager+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSFileManager+AMPExtensions.h"

#define AMPOnce(block) \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, block);

#define AMPOnceURL(block) \
    static NSURL *url = nil; \
    AMPOnce(block); \
    \
    return url;

#define AMPOnceURLForDirectoryWithSearchPathAndDoamin(searchPath, domain) \
    AMPOnceURL(^{ \
        url = [self URLsForDirectory:searchPath inDomains:domain].firstObject; \
    });

@implementation NSFileManager (AMPExtensions)

- (NSURL *)URLForLibraryDirectory {
    AMPOnceURLForDirectoryWithSearchPathAndDoamin(NSLibraryDirectory, NSUserDomainMask);
}

- (NSURL *)URLForDocumentsDirectory {
    AMPOnceURLForDirectoryWithSearchPathAndDoamin(NSDocumentDirectory, NSUserDomainMask);
}

- (NSURL *)URLForDirectoryInLibraryDirectory:(NSString *)directoryName {
    AMPOnceURL(^{
        url = [[self URLForLibraryDirectory] URLByAppendingPathComponent:directoryName];
        NSFileManager *manager = [NSFileManager defaultManager];
        if (![manager createDirectoryAtPath:url.path
                withIntermediateDirectories:YES
                                 attributes:nil
                                      error:nil]) {
            url = nil;
        }
    });
}

- (NSString *)fileNameWithURL:(NSURL *)url {
    if (url.isFileURL) {
        return url.lastPathComponent;
    }
    
    return [[url.path stringByRemovingPercentEncoding] stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
}

- (long long)fileSizeAtPath:(NSString *)path {
    NSDictionary *fileAttributes = [self attributesOfItemAtPath:path error:nil];
    
    return [fileAttributes[NSFileSize] longLongValue];
}

@end
