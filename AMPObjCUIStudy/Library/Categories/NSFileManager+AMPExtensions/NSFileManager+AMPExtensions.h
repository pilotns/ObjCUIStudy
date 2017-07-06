//
//  NSFileManager+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 05.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (AMPExtensions)

- (NSURL *)URLForLibraryDirectory;
- (NSURL *)URLForDocumentsDirectory;
- (NSURL *)URLForDirectoryInLibraryDirectory:(NSString *)directoryName;

- (NSString *)fileNameWithURL:(NSURL *)url;

@end
