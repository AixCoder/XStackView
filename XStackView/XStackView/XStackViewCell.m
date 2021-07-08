//
//  XStackViewCell.m
//  AloeStackView
//
//  Created by liuhongnian on 2019/9/11.
//  Copyright © 2019年 Airbnb, Inc. All rights reserved.
//

#import "XStackViewCell.h"

@interface XStackViewCell ()
@property (nonatomic,strong) UIView *contentView;

@property (nonatomic, strong) UITapGestureRecognizer *singleTap;
@end


@implementation XStackViewCell

- (instancetype)initWithContentView:(UIView *)content
{
    if (self = [super initWithFrame:CGRectZero]) {
        
        _contentView = content;
        
        [self setupContentView];
        [self setupSelf];
        [self setupConstraints];
        [self setupTapGestureRecognizer];
        
    }
    
    return self;
}

- (void)setupSelf
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
}

- (void)setupContentView
{
    _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_contentView];
}

- (void)setupConstraints
{
    [self setupContentViewConstraint];
}

- (void)setupContentViewConstraint
{
    
    NSLayoutConstraint *bottomConstraint = [_contentView.bottomAnchor constraintEqualToAnchor:self.layoutMarginsGuide.bottomAnchor];
    bottomConstraint.priority = UILayoutPriorityRequired - 2;
    
    
    [NSLayoutConstraint activateConstraints:@[[_contentView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [_contentView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              [_contentView.rightAnchor constraintEqualToAnchor:self.rightAnchor]]];
    
    bottomConstraint.active = YES;
    
}

- (void)setupTapGestureRecognizer
{
    _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                         action:@selector(singleTapped)];
    
    [self addGestureRecognizer:_singleTap];
    
    [self updateTapGestureRecoginzer];
    
}

- (void)updateTapGestureRecoginzer
{
    _singleTap.enabled = (_tapHandler != nil) ? YES : NO;
    
    
}

- (void)singleTapped
{
    if (self.tapHandler) {
        self.tapHandler(_contentView);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setRowBackGroundColor:(UIColor *)rowBackGroundColor
{
    
    if (rowBackGroundColor != nil) {
        _rowBackGroundColor = rowBackGroundColor;
        self.backgroundColor = rowBackGroundColor;
    }
}

- (void)setTapHandler:(void (^)(UIView * _Nonnull))tapHandler
{
    if (tapHandler) {
        _tapHandler = tapHandler;
    }
    
    [self updateTapGestureRecoginzer];
}

@end
