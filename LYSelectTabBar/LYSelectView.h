//
//  LYSelectButton.h
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LYTabBatAssistBtnStatus){
    LYTabBatAssistBtn_Desc = 0 ,
    LYTabBatAssistBtn_Asc,
    LYTabBatAssistBtn_Nomal
};

@interface LYSelectView : UIView

@property (nonatomic,strong,readonly) UIButton *tabImageBtn;

@property (nonatomic,strong,readonly) UIButton *tabButton;

@property (nonatomic,strong,readonly) UILabel *badgeLabel;

@property (nonatomic,assign,readonly) BOOL isSelected;
@property (nonatomic,assign) BOOL hasOrderImage;

@property (nonatomic,assign) int assistStatus;

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font
                     selImage:(UIImage *)selImage unSelImage:(UIImage *)unSelImage
                     selColor:(UIColor *)selColor unSelColor:(UIColor *)unSelColor;

- (void)setBadgeValue:(NSString *)badgeValue;
- (void)doSelectAction;
- (void)doAssistAction;

- (void)addAssist:(NSString *)normalImage descImage:(NSString *)descImage ascImage:(NSString *)ascImage;


@end
