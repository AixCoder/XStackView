//
//  XStackViewCell.h
//  AloeStackView
//
//  Created by liuhongnian on 2019/9/11.
//  Copyright © 2019年 Airbnb, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
//
@interface XStackViewCell : UIView

@property (nonatomic,strong) UIColor *rowBackGroundColor;

@property (nonatomic, copy) void(^_Nullable tapHandler)(UIView *contentView);

- (instancetype)initWithContentView:(UIView *)content;

@end

NS_ASSUME_NONNULL_END
