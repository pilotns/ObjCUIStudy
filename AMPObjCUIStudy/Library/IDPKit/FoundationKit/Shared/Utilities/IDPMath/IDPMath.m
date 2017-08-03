//
//  IDPMath.m
//  AnotherTossGame
//
//  Created by Artem Chabanniy on 17/10/2013.
//  Copyright (c) 2013 IDAP Group. All rights reserved.
//

#import "IDPMath.h"

NSInteger IDPRandomNumber(NSInteger range) {
    return IDPRandomNumberInRange(0, range);
}

NSInteger IDPRandomNumberInRange(NSInteger min, NSInteger max) {
    return arc4random_uniform((uint32_t)(max - min)) + min;
}
