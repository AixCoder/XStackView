//
//  XStackView.h
//  AloeStackView
//
//  Created by liuhongnian on 2019/9/11.
//  Copyright © 2019年 Airbnb, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XStackView : UIScrollView

@property (nonatomic,strong) UIColor *rowBackGroundColor;//default white

- (void)addRow:(UIView *)subRow;
- (void)addRow:(UIView *)subRow animated:(BOOL)animated;

- (void)addRows:(NSArray<UIView *>*)rows;
- (void)addRows:(NSArray<UIView *>*)rows
       animated:(BOOL)animated;

- (void)removeRow:(UIView *)subRow animated:(BOOL)animated;


- (void)setTapHandlerForRow:(UIView *)row
                    handler:(void(^)(UIView *row))handlerBlock;



@end

NS_ASSUME_NONNULL_END
