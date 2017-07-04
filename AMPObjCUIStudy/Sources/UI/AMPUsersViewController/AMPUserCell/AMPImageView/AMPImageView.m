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

#import "AMPView+AMPLoadingView.h"

@interface AMPImageView ()
@property (nonatomic, strong)   UIImageView     *contentImageView;

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

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initSubviews];
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setImageModel:(AMPImageModel *)imageModel {
    if (_imageModel != imageModel) {
        [_imageModel removeObserver:self];
        
        _imageModel = imageModel;
        [_imageModel addObserver:self];

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
    imageView.autoresizingMask = AMPUIViewAutoresizingAll;
    
    self.contentImageView = imageView;
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelWillLoad:(id)model {
    [self presentLoadingViewAnimated:YES];
}

- (void)modelDidLoad:(AMPImageModel *)model {
    AMPDispatchSyncOnMainQueue(^{
        [self dismissLoadingViewAnimated:YES];
        [self fillWithModel:model];
    });
}

@end
