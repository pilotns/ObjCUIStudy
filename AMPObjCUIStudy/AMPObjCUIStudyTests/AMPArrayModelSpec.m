//
//  AMPArrayModelSpec.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 20.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "Kiwi.h"

#import "AMPArrayModel.h"

#import "NSObject+AMPExtensions.h"

SPEC_BEGIN(AMPArrayModelSpec)

describe(@"AMPArrayModel", ^{
    NSObject *object1 = [NSObject new];
    NSObject *object2 = [NSObject new];
    AMPArrayModel *model = [[AMPArrayModel alloc] initWithObjects:@[object1, object2]];
    
    context(@"when create model with two objects", ^{
        it(@"object at index 0 should equal to object1", ^{
            [[model[0] should] equal:object1];
        });
        
        it(@"object at index 1 should equal to object2", ^{
            [[model[1] should] equal:object2];
        });
    });
    
    context(@"when move object at index 0 to index 1", ^{
        beforeAll(^{
            [model moveObjectAtIndex:0 toIndex:1];
        });
        
        it(@"object at index 0 should equal object2", ^{
            [[model[0] should] equal:object2];
        });
        
        it(@"object at index 1 should equal object1", ^{
            [[model[1] should] equal:object1];
        });
    });
    
    context(@"when move object at index 1 to index 0", ^{
        beforeAll(^{
            [model moveObjectAtIndex:1 toIndex:0];
        });
        
        it(@"object at index 0 should equal object1", ^{
            [[model[0] should] equal:object1];
        });
        
        it(@"object at index 1 should equal object2", ^{
            [[model[1] should] equal:object2];
        });
    });
});

SPEC_END
