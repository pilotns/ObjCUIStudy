//
//  AMPImageView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPImageView.h"

#import "AMPImageModel.h"
#import "AMPGCDExtensions.h"
#import "AMPMacro.h"

@interface AMPImageView ()

- (void)fillWithModel:(AMPImageModel *)model;
- (void)initSubviews;

@end

@implementation AMPImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.imageModel = nil;
    self.contentImageView = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self initSubviews];
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    if (!self.contentImageView) {
        [self initSubviews];
    }
}

#pragma mark -
#pragma mark Accessors

- (void)setImageModel:(AMPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel removeListener:self];
        
        _imageModel = imageModel;
        [_imageModel addListener:self];

        [_imageModel load];
    }
}

- (void)setContentImageView:(UIImageView *)contentImageView {
    if (_contentImageView != contentImageView) {
        [_contentImageView removeFromSuperview];
        
        _contentImageView = contentImageView;
        [self addSubview:contentImageView];
    }
}

#pragma mark -
#pragma mark Private Methods

- (void)fillWithModel:(AMPImageModel *)model {
    self.contentImageView.image = model.image;
}

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.contentImageView = imageView;
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelWillLoad:(id)model {
    AMPDispatchAsyncOnMainQueue(^{
        [self setLoadingViewVisible:YES];
    });
}

- (void)modelDidLoad:(AMPImageModel *)model {
    AMPDispatchAsyncOnMainQueue(^{
        [self setLoadingViewVisible:NO];
        [self fillWithModel:model];
    });
}

@end
