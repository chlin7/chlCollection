//
//  HLTitleButton.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/1.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLTitleButton.h"

#define HLTitleButtonImageWidth 20

@implementation HLTitleButton

+(instancetype)titleButton{
    return [[self alloc] init];
}

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //按钮图片高亮不要自动调整图标颜色
        self.adjustsImageWhenHighlighted = NO;
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = [UIFont systemFontOfSize:19.0];
        //背景
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        //文字和frame
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
    return self;
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imageH = contentRect.size.height;
    CGFloat imageW = HLTitleButtonImageWidth;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = 0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleW = contentRect.size.width-HLTitleButtonImageWidth;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}
@end
