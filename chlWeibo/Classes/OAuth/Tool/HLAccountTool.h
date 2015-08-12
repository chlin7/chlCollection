//
//  HLAccountTool.h
//  chlWeibo
//
//  Created by chlin7 on 15/8/6.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HLAccount;

@interface HLAccountTool : NSObject

/**
 *  存储账号信息
 *
 *  @param account
 */
+(void)saveAccount:(HLAccount *)account;

+(HLAccount *)account;


@end
