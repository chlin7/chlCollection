//
//  HLBadgeButton.m
//  chlWeibo
//
//  Created by chlin7 on 15-6-7.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLBadgeButton.h"

@implementation HLBadgeButton

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:(UIControlStateNormal)];
        [self.titleLabel setFont:[UIFont systemFontOfSize:11.0]];
    }
    return self;
}

-(void)setBadgeValue:(NSString *)badgeValue{
    _badgeValue = [badgeValue copy];
    //模仿系统tabBar的badgeValue属性
    if (badgeValue) {
        self.hidden = NO;
        [self setTitle:badgeValue forState:(UIControlStateNormal)];
        
        //frame
        CGRect frame = self.frame;
        
        CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
        CGFloat badgeButtonH = self.currentBackgroundImage.size.height;
        CGFloat badgeButtonW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1) {
            badgeButtonW = badgeSize.width + 10;
        }
        frame.size.width = badgeButtonW;
        frame.size.height = badgeButtonH;
        
        self.frame = frame;
    }else{
        self.hidden = YES;
    }
}

@end
