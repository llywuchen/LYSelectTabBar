//
//  LYSelectButton.h
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYSelectView : UIView

@property (nonatomic,assign,readonly) BOOL isSelected;
@property (nonatomic,assign) BOOL hasOrderImage;

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font
                     selImage:(UIImage *)selImage unSelImage:(UIImage *)unSelImage
                     selColor:(UIColor *)selColor unSelColor:(UIColor *)unSelColor;

- (void)setOrderImage:(NSString *)image isLeft:(BOOL)isLeft;
- (void)setBadgeValue:(NSString *)badgeValue;
- (void)doSelectAction;

//- (void)addActionTarget:(id)target sel:(SEL)sel;

@end
