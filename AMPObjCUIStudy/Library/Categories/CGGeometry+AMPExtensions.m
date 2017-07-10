//
//  CGGeometry+AMPExtensions.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 10.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "CGGeometry+AMPExtensions.h"

CGPoint AMPCGRectCenter(CGRect rect) {
    return CGPointMake(CGMidX(rect), CGMidY(rect));
}
