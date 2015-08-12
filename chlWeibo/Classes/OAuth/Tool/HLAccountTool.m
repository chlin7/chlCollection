//
//  HLAccountTool.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/6.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLAccountTool.h"
#import "HLAccount.h"

#define HLAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"account.data"]

@implementation HLAccountTool

+(void)saveAccount:(HLAccount *)account{
    
    //当前时间
    NSDate *now = [NSDate date];
    
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:HLAccountFile];
}

+(HLAccount *)account{
    
    HLAccount *currentAccount = [NSKeyedUnarchiver unarchiveObjectWithFile:HLAccountFile];
    
    //判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:currentAccount.expiresTime] == NSOrderedAscending) {//账号没过期
        return currentAccount;
    }else{
        return nil;
    }
}
@end
