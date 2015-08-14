//
//  HLStatusFrame.h
//  chlWeibo
//
//  Created by chlin7 on 15/8/9.
//  Copyright (c) 2015年 chlin7. All rights reserved.
// 一个cell对应一个frame

/**
 *  cell的边框宽度
 */
#define HLStatusCellBorder 10
/**
 *  cell昵称的字体
 */
#define HLStatusNameLabelFont [UIFont systemFontOfSize:14.0]
/**
 *  cell时间的字体
 */
#define HLStatusTimeLabelFont [UIFont systemFontOfSize:12.0]
/**
 *  cell来源的字体
 */
#define HLStatusSourceLabelFont HLStatusTimeLabelFont
/**
 *  cell正文的字体
 */
#define HLStatusContentLabelFont [UIFont systemFontOfSize:13.0]

/**
 *  cell被转微博昵称的字体
 */
#define HLStatusRetweetNameLabelFont HLStatusNameLabelFont
/**
 *  cell被转发微博正文的字体
 */
#define HLStatusRetweetContentLabelFont HLStatusContentLabelFont
/**
 *  微博展示边艰巨
 */
#define HLStatusTableBorder 5


#import <Foundation/Foundation.h>
@class HLStatus;

@interface HLStatusFrame : NSObject
/**
 *  cell的数据
 */
@property(nonatomic,strong)HLStatus *status;
/**
 *  cell的高度（根据cell的内容计算）
 */
@property(nonatomic,assign,readonly)CGFloat cellHeight;


/**
 每条微博的背景View
 */
@property(nonatomic,assign,readonly)CGRect topViewFrame;
/**
 头像
 */
@property(nonatomic,assign,readonly)CGRect iconViewFrame;
/**
 会员标志
 */
@property(nonatomic,assign,readonly)CGRect vipViewFrame;
/**
 配图
 */
@property(nonatomic,assign,readonly)CGRect photoViewFrame;
/**
 昵称
 */
@property(nonatomic,assign,readonly)CGRect nameLabelFrame;
/**
 时间
 */
@property(nonatomic,assign,readonly)CGRect timeLabelFrame;
/**
 来源
 */
@property(nonatomic,assign,readonly)CGRect sourceLabelFrame;
/**
 正文内容
 */
@property(nonatomic,assign,readonly)CGRect contentLabelFrame;

/**
 被转发微博的背景view
 */
@property(nonatomic,assign,readonly)CGRect retweetViewFrame;
/**
 被转发微博的作者昵称
 */
@property(nonatomic,assign,readonly)CGRect retweetNameLabelFrame;
/**
 被转发微博的正文内容
 */
@property(nonatomic,assign,readonly)CGRect retweetContentLabelFrame;
/**
 被转发微博的配图
 */
@property(nonatomic,assign,readonly)CGRect retweetPhotoViewFrame;

/**
 微博的工具条view
 */
@property(nonatomic,assign,readonly)CGRect statusToolBarViewFrame;

@end
