//
//  AMPImageView.m
//  AMPObjCUIStudy
//
//  Created by pilotns on 23.06.17.
//  Copyright © 2017 pilotns. All rights reserved.
//

#import "AMPImageView.h"

#import "AMPImageModel.h"
#import "AMPLoadingView.h"

@interface AMPImageView ()
@property (nonatomic, strong)   UIImageView     *contentImageView;
@property (nonatomic, strong)   AMPLoadingView  *loadingView;

- (void)initSubviews;

@end

@implementation AMPImageView

#pragma mark -
#pragma mark Initializations and Deallocations

- (void)dealloc {
    self.imageModel = nil;
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
        [_imageModel dump];
        [_imageModel removeObserver:self];
        
        _imageModel = imageModel;
        [_imageModel addObserver:self];
        
        self.loadingView = [AMPLoadingView loadingViewWithView:self];
        [_imageModel load];
    }
}

- (void)setLoadingView:(AMPLoadingView *)loadingView {
    if (_loadingView != loadingView) {
        [_loadingView dismiss];
        
        _loadingView = loadingView;
        [_loadingView present];
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

- (void)initSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
                                | UIViewAutoresizingFlexibleRightMargin
                                | UIViewAutoresizingFlexibleTopMargin
                                | UIViewAutoresizingFlexibleBottomMargin;
    
    self.contentImageView = imageView;
}

#pragma mark -
#pragma mark AMPModelObserver

- (void)modelDidFinishLoading:(AMPImageModel *)model {
    self.contentImageView.image = model.image;
    self.loadingView = nil;
}

@end
