//
//  AMPMarcos.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 02.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#ifndef AMPMarcos_h
#define AMPMarcos_h

#define AMPWeakify(object) \
    __weak typeof(object) weak_##object = object;

#define AMPStrongify(object) \
    __strong typeof(object) object = weak_##object; \
    if (!object) { \
        return; \
    }

#endif /* AMPMarcos_h */
