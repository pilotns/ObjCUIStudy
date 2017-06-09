//
//  AMPRandom.h
//  AMPObjCStudy
//
//  Created by pilotns on 23.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <Foundation/Foundation.h>

NSRange AMPMakeRange(NSUInteger firstNumber, NSUInteger lastNumber);
NSUInteger AMPRandomValueUntilLocation(NSUInteger location);
NSUInteger AMPRandomValueWithRange(NSRange range);

