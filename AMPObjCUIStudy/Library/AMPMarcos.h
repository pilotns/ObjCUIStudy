//
//  AMPMarcos.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#ifndef AMPMarcos_h
#define AMPMarcos_h

#import "AMPCGShortCuts.h"

#define AMPPragmaDiagnosticPushWshadow \
    _Pragma("clang diagnostic push"); \
    _Pragma("clang diagnostic ignored \"-Wshadow\"");

#define AMPPragmaDiagnosticPop \
    _Pragma("clang diagnostic pop")

#define AMPEmptyParameter

#define AMPWeakify(object) \
    __weak typeof(object) weak_##object = object;

#define AMPStrongify(object) \
    AMPPragmaPushWshadow \
        __strong typeof(object) object = weak_##object; \
    AMPPragmaPop

#define AMPStrongifyAndReturnIfNil(object) \
    AMPStrongifyAndReturnValueIfNil(object, AMPEmptyParameter)

#define AMPStrongifyAndReturnNilIfNil(object) \
    AMPStrongifyAndReturnValueIfNil(object, nil)

#define AMPStrongifyAndReturnValueIfNil(object, value) \
    AMPPragmaDiagnosticPushWshadow \
        __strong typeof(object) object = weak_##object; \
        if (!object) { \
            return value; \
        } \
    AMPPragmaDiagnosticPop

#endif /* AMPMarcos_h */
