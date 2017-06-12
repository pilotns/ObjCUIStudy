//
//  NSString+AMPRandom.h
//  AMPObjCStudy
//
//  Created by pilotns on 13.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

NSRange AMPMakeCharacterRange(unichar firstCharacter, unichar lastCharacter);

@interface NSString (AMPRandom)

// return random string containing English lowercase letters,
// whose length is equal 6
+ (instancetype)randomName;

// return random string containing English lowercase letters,
// whose length in range 0..10
+ (instancetype)randomString;

// return random string containing English lowercase letters
// with specific length
+ (instancetype)randomStringWithLength:(NSUInteger)length;

// return random string containing specific symbols with specific length
// You must use the AMPMakeCharacterRange function, to create the correct range
+ (instancetype)randomStringWithLength:(NSUInteger)length characterRange:(NSRange)characterRange;

@end
