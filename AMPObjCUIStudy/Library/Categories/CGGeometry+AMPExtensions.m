//
//  CGGeometry+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 09.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "CGGeometry+AMPExtensions.h"

CGPoint CGRectCenter(CGRect rect) {
    return CGPointMake(CGMidX(rect), CGMidY(rect));
}
