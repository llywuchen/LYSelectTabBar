//
//  LYSelectButton.m
//  LYSelectTabBar
//
//  Created by lly on 16/12/19.
//  Copyright © 2016年 franklin. All rights reserved.
//

#import "LYSelectView.h"

@interface LYSelectView ()

@property (nonatomic,strong) NSString *normalImage;
@property (nonatomic,strong) NSString *descImage;
@property (nonatomic,strong) NSString *ascImage;

@property (nonatomic,assign) BOOL showTabImage;
@property (nonatomic,assign) BOOL needAssistLayout;
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
        make.top.centerX.equalTo(self);
        make.width.equalTo(self.mas_width);
        make.height.equalTo(self).multipliedBy(_showTabImage?(0.66f):0);
    }];
    [_tabButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(_showTabImage?-10:0);
        make.top.equalTo(_tabImageBtn.mas_bottom);
    }];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if(_needAssistLayout){
        _needAssistLayout = false;
        CGFloat imgWidth = self.tabButton.currentImage.size.width;
        CGFloat titleWidth = self.tabButton.frame.size.width - imgWidth - 6;
        self.tabButton.titleEdgeInsets = UIEdgeInsetsMake(0, -6 , 0, 0);
        self.tabButton.imageEdgeInsets = UIEdgeInsetsMake(0, titleWidth +imgWidth+6, 0, -6);
    }
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

- (void)setAssistStatus:(int)assistStatus{
    if(assistStatus == LYTabBatAssistBtn_Nomal){
        [self.tabButton setImage:[UIImage imageNamed:_normalImage] forState:UIControlStateNormal];
        [self.tabButton setImage:[UIImage imageNamed:_normalImage] forState:UIControlStateSelected];
    }else{
        _assistStatus = assistStatus;
        [self.tabButton setImage:[UIImage imageNamed:_assistStatus== LYTabBatAssistBtn_Desc? _descImage:_ascImage] forState:UIControlStateNormal];
        [self.tabButton setImage:[UIImage imageNamed:_assistStatus== LYTabBatAssistBtn_Desc? _descImage:_ascImage] forState:UIControlStateSelected];
    }
}

#pragma mark -
#pragma mark - action
- (void)addAssist:(NSString *)normalImage descImage:(NSString *)descImage ascImage:(NSString *)ascImage{
    _normalImage = normalImage;
    _descImage = descImage;
    _ascImage = ascImage;
    _needAssistLayout = YES;
    self.assistStatus = LYTabBatAssistBtn_Nomal;
    [self setNeedsLayout];
}

- (void)doSelectAction{
    if(self.normalImage.length>0){
        if(!_tabButton.isSelected){
            self.assistStatus = _assistStatus;
        }else{
            self.assistStatus = LYTabBatAssistBtn_Nomal;
        }
    }
    [_tabButton setSelected:!_tabButton.isSelected];
    [_tabImageBtn setSelected:!_tabImageBtn.isSelected];
}

- (void)doAssistAction{
    if(self.normalImage.length>0){
        self.assistStatus = _assistStatus!= LYTabBatAssistBtn_Desc?LYTabBatAssistBtn_Desc:LYTabBatAssistBtn_Asc;
    }
}

@end
