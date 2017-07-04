//
//  AMPCGShortCuts.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 09.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

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

#define CGRectCenter(rect) CGPointMake(CGMidX(rect), CGMidY(rect))

#endif /* AMPCGShortCuts_h */
