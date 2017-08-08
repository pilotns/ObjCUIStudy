//
//  NSFileManager+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "NSFileManager+AMPExtensions.h"

#import "AMPGCDExtensions.h"

#define AMPOnceURLForDirectoryWithSearchPathAndDoamin(searchPath) \
    AMPOnce(^{ \
        return [self URLsForDirectory:searchPath inDomains:NSUserDomainMask].firstObject; \
    });

@implementation NSFileManager (AMPExtensions)

- (NSURL *)URLForLibraryDirectory {
    AMPOnceURLForDirectoryWithSearchPathAndDoamin(NSLibraryDirectory);
}

- (NSURL *)URLForDocumentsDirectory {
    AMPOnceURLForDirectoryWithSearchPathAndDoamin(NSDocumentDirectory);
}

- (NSURL *)URLForDirectoryInLibraryDirectory:(NSString *)directoryName {
    NSURL *url = [[self URLForLibraryDirectory] URLByAppendingPathComponent:directoryName];
    if ([self createDirectoryAtPath:url.path
        withIntermediateDirectories:YES
                         attributes:nil
                              error:nil])
    {
        return url;
    }
    
    return nil;
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
