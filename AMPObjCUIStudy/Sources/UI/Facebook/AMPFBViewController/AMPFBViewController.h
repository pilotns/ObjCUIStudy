//
//  AMPFBViewController.h
//  AMPObjCUIStudy
//
//  Created by pilotns on 18.07.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AMPModel;
@class AMPContext;

@interface AMPFBViewController : UIViewController
@property (nonatomic, strong)   id          model;
@property (nonatomic, strong)   AMPContext  *context;

@property (nonatomic, readonly, getter=isAuthorized)    BOOL    authorized;

// this method is intended for subclassing, do not call it directly
- (void)fillWithModel:(id)model;

@end
