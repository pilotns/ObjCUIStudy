//
//  AMPFBViewController.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 18.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPViewController.h"

@class AMPModel;
@class AMPContext;

@interface AMPFBViewController : AMPViewController
@property (nonatomic, strong)   AMPModel    *model;
@property (nonatomic, strong)   AMPContext  *context;

// this method is intended for subclassing, do not call it directly
- (void)fillWithModel:(id)model;

@end
