//
//  CGGeometry+AMPExtensions.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 09.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <CoreGraphics/CoreGraphics.h>

#ifndef AMPCGShortCuts_h
#define AMPCGShortCuts_h

#define CGMaxX CGRectGetMaxX
#define CGMinX CGRectGetMinX

#define CGMaxY CGRectGetMaxY
#define CGMinY CGRectGetMinY

#define CGMidX CGRectGetMidX
#define CGMidY CGRectGetMidY

#define CGWidth CGRectGetWidth
#define CGHeight CGRectGetHeight

CGPoint AMPCGrectCenter(CGRect rect);

#endif /* AMPCGShortCuts_h */
