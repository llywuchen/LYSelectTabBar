//
//  LYSelectButton.m
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYSelectView.h"

@interface LYSelectView ()

//@property (nonatomic,strong) UIButton *tabImageBtn;
//
//@property (nonatomic,strong) UIButton *tabButton;
//
//@property (nonatomic,strong) UILabel *badgeLabel;

@property (nonatomic,assign) BOOL showTabImage;

@end

@implementation LYSelectView

- (instancetype)initWithTitle:(NSString *)title font:(UIFont *)font selImage:(UIImage *)selImage unSelImage:(UIImage *)unSelImage selColor:(UIColor *)selColor unSelColor:(UIColor *)unSelColor{
    self = [super init];
    if(self){
        _tabButton = [[UIButton alloc]init];
        [_tabButton setTitle:title forState:UIControlStateNormal];
        [_tabButton setTitleColor:unSelColor forState:UIControlStateNormal];
        [_tabButton setTitleColor:selColor forState:UIControlStateSelected];
        [_tabButton setTitleColor:selColor forState:UIControlStateHighlighted];
        [_tabButton.titleLabel setFont:font];
        [self addSubview:_tabButton];
        
        _tabImageBtn = [[UIButton alloc]init];
        [_tabImageBtn setImage:unSelImage forState:UIControlStateNormal];
        [_tabImageBtn setImage:selImage forState:UIControlStateSelected];
        [_tabImageBtn setImage:selImage forState:UIControlStateHighlighted];
        [self addSubview:_tabImageBtn];
        
        _showTabImage = (selImage!=nil);
        [self setclickEnable:NO];
        [self configureContraints];
    }
    return self;
}


- (void)configureContraints{
    [_tabImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@0);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self).multipliedBy(_showTabImage?(0.66f):0);
    }];
    [_tabButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(self).offset(-10);
        make.top.equalTo(_tabImageBtn.mas_bottom);
    }];
}

#pragma mark -
#pragma mark - getter and setter
- (BOOL)isSelected{
    return _tabButton.isSelected;
}

- (void)setclickEnable:(BOOL)enable{
    _tabButton.userInteractionEnabled = enable;
    _tabImageBtn.userInteractionEnabled = enable;
}

- (void)setOrderImage:(NSString *)image isLeft:(BOOL)isLeft{
    
}

- (void)setBadgeValue:(NSString *)badgeValue{
    
}

#pragma mark -
#pragma mark - action
- (void)doSelectAction{
    [_tabButton setSelected:!_tabButton.isSelected];
    [_tabImageBtn setSelected:!_tabImageBtn.isSelected];
}

//- (void)setSelected:(BOOL)selected{
//    [_tabButton setSelected:selected];
//    [_tabImageBtn setSelected:selected];
//}

- (void)addActionTarget:(id)target sel:(SEL)sel{
    [self setclickEnable:YES];
    [_tabButton addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    [_tabImageBtn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
}

@end
