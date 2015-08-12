//
//  HLStatus.h
//  chlWeibo
//
//  Created by chlin7 on 15/8/8.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HLUser;
@interface HLStatus : NSObject
/**
 *  微博内容
 */
@property(nonatomic,copy)NSString *text;
/**
 *  微博的来源
 */
@property(nonatomic,copy)NSString *source;
/**
 *  微博的时间
 */
@property(nonatomic,copy)NSString *created_at;
/**
 *  微博的主键
 */
@property(nonatomic,copy)NSString* idstr;
/**
 *  微博转发数
 */
@property(nonatomic,assign) int reposts_count;
/**
 *  评论数
 */
@property(nonatomic,assign) int comments_count;

/**
 *  表态数
 */
@property(nonatomic,assign) int attitudes_count;
/**
 *  微博的作者
 */
@property(nonatomic,strong)HLUser *user;
/**
 *  微博的配图(暂时一张)
 */
@property(nonatomic,copy)NSString *thumbnail_pic;
/**
 *  被转发的weib
 */
@property(nonatomic,strong)HLStatus *retweeted_status;


@end

