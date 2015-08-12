//
//  HLAccount.h
//  chlWeibo
//  新浪账号模型
//  Created by chlin7 on 15/8/5.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HLAccount : NSObject<NSCoding>

@property(nonatomic,copy) NSString *access_token;

//账号的过期时间
@property(nonatomic,strong)NSDate *expiresTime;

//如果服务器返回的数字很大，建议用long long
@property(nonatomic,assign) long long expires_in;
@property(nonatomic,assign) long long remind_in;
@property(nonatomic,assign) long long uid;

+(instancetype)accountWithDict:(NSDictionary *)dict;

-(instancetype)initWithDict:(NSDictionary *)dict;

@end
