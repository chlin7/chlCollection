//
//  HLUser.h
//  chlWeibo
//
//  Created by chlin7 on 15/8/8.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLUser : NSObject
/**
 *  用户的id
 */
@property(nonatomic,copy)NSString* idstr;
/**
 *  用户昵称
 */
@property(nonatomic,copy)NSString *name;
/**
 *  用户的头像
 */
@property(nonatomic,copy)NSString *profile_image_url;
/**
 *  是否是VIP
 */

@property(nonatomic,assign,getter=isVip) BOOL vip;

@end
