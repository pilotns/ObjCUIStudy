//
//  AMPRandom.h
//  AMPObjCStudy
//
//  Created by pilotns on 23.04.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPRandom.h"

NSRange AMPMakeRange(NSUInteger firstNumber, NSUInteger lastNumber) {
    NSUInteger minValue = MIN(firstNumber, lastNumber);
    NSUInteger maxValue = MAX(firstNumber, lastNumber);
    
    return NSMakeRange(minValue, maxValue - minValue + 1);
}

NSUInteger AMPRandomValueUntilLocation(NSUInteger location) {
    return arc4random_uniform((uint32_t)location);
}

NSUInteger AMPRandomValueWithRange(NSRange range) {
    return arc4random_uniform((uint32_t)range.length) + range.location;
}

BOOL AMPRandomBool() {
    return AMPRandomValueUntilLocation(2);
}
