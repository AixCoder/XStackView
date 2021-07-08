//
//  XStackView.m
//  AloeStackView
//
//  Created by liuhongnian on 2019/9/11.
//  Copyright © 2019年 Airbnb, Inc. All rights reserved.
//

#import "XStackView.h"

#import "XStackViewCell.h"

@interface XStackView ()

@property (nonatomic, strong) UIStackView *stackView;

@end

@implementation XStackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    //please use init with frame
    NSAssert(false, @"");
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSelf];
        [self setupSubViews];
        [self setupConstraints];
    }
    return self;
}

- (instancetype)init
{
    if (self = [super initWithFrame:CGRectZero]) {
        [self setupSubViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupSelf
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.rowBackGroundColor = UIColor.whiteColor;
    
}

- (void)setupSubViews
{
    [self setupStackView];
}
         
- (void)setupStackView
{
    _stackView = [[UIStackView alloc] initWithFrame:CGRectZero];
    _stackView.translatesAutoresizingMaskIntoConstraints = NO;
    _stackView.axis = UILayoutConstraintAxisVertical;
    [self addSubview:_stackView];
}

- (void)setupConstraints
{
    [NSLayoutConstraint activateConstraints:@[[_stackView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [_stackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
                                              [_stackView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              [_stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
                                              [_stackView.widthAnchor constraintEqualToAnchor:self.widthAnchor]]];
}


- (void)addRow:(UIView *)subRow
{
    [self addRow:subRow animated:NO];
}

- (void)addRows:(NSArray<UIView *> *)rows
{
    __weak typeof(self) weakSelf = self;
    
    [rows enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [weakSelf addRow:obj animated:NO];
    }];
}

- (void)addRows:(NSArray<UIView *> *)rows animated:(BOOL)animated
{
    __weak typeof(self) weakSelf = self;
    
    [rows enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [weakSelf addRow:obj animated:animated];
    }];
}

- (void)addRow:(UIView *)subRow animated:(BOOL)animated
{
    [self insertCellWithContent:subRow
                        atIndex:_stackView.arrangedSubviews.count
                       animated:animated];
}

- (void)insertCellWithContent:(UIView *)contentView atIndex:(NSUInteger)index animated:(BOOL)animated
{
    XStackViewCell *cellWillRemove = [self containsRow:contentView] ? (XStackViewCell *)contentView.superview : nil;
    
    XStackViewCell *cell = [[XStackViewCell alloc] initWithContentView:contentView];
    cell.rowBackGroundColor = _rowBackGroundColor;
    
    [_stackView insertArrangedSubview:cell atIndex:index];
    
    if (cellWillRemove) {
        [self removeCell:cellWillRemove animated:animated];
    }
    
    if (animated) {
        cell.alpha = 0;
        [UIView animateWithDuration:0.4 animations:^{
            cell.alpha = 1;
        }];
    }
}

- (void)removeCell:(XStackViewCell *)cell animated:(BOOL)animated
{
    __weak typeof(self) weakSelf = self;
    void (^completion)(void) = ^{
        if (weakSelf) {
            [weakSelf.stackView removeArrangedSubview:cell];
        }
    };
    
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            cell.hidden = YES;
        } completion:^(BOOL finished) {
            completion();
        }];
    }else{
        
        completion();
    }
    
}


- (void)removeRow:(UIView *)subRow animated:(BOOL)animated
{
    
    if ([subRow.superview isKindOfClass:[XStackViewCell class]]) {
        
        XStackViewCell *cell = (XStackViewCell *)subRow.superview;
        [self removeCell:cell animated:animated];
    }
}

- (void)setTapHandlerForRow:(UIView *)row handler:(void (^)(UIView * _Nonnull))handlerBlock
{
    XStackViewCell *cell = (XStackViewCell *)row.superview;
    if (cell && [cell isKindOfClass:[XStackViewCell class]]) {
        
        if (handlerBlock) {
            cell.tapHandler = handlerBlock;
        }else{
            cell.tapHandler = nil;
        }
    }
}

#pragma mark prive method

- (BOOL)containsRow:(UIView *)row
{
    return [_stackView.arrangedSubviews containsObject:row.superview];
}

@end
