//
//  HLSearchBar.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLSearchBar.h"

@interface HLSearchBar()
@property(nonatomic,weak)UIImageView *iconView;
@end
@implementation HLSearchBar

+(instancetype)searchBar{
    return [[self alloc] init];
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        //左边放大镜
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithName:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.iconView = iconView;
        //字体
        self.font = [UIFont systemFontOfSize:13.0];
        //右边清楚按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        //设置提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        //设置键盘右下角按钮的样式
        self.returnKeyType = UIReturnKeySearch;
        self.enablesReturnKeyAutomatically = YES;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置左边图标的frame
    self.leftView.frame = CGRectMake(0, 0, 20, self.frame.size.height);
}

@end
