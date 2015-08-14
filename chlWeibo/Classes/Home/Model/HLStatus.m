//
//  HLStatus.m
//  chlWeibo
//  微博数据模型（一个status对象对应一条微博）
//  Created by chlin7 on 15/8/8.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLStatus.h"
#import "HLUser.h"

@implementation HLStatus

-(NSString *)created_at{
    
    return [self cc:_created_at];
}
/**
 *  处理时间的方法
 */
-(NSString *)cc:(NSString *)create_at{
    //1.获取时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM d HH:mm:ss z yyyy";
    NSDate *createdDate = [fmt dateFromString:create_at];
    //2.计算和当前时间的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    if ([calendar isDateInToday:createdDate]) {//今天
        return @"刚刚";
    }else if([calendar isDateInYesterday:createdDate]){
        return @"不是今天";
    }
    return @"";
}
/**
 *  字典转模型的时候调用，所以不用get方法，用set方法保证一些不变的数据不每次都执行
 *
 *  @param source <#source description#>
 */
-(void)setSource:(NSString *)source{
    
    NSUInteger startLoc = [source rangeOfString:@">"].location + 1;
    
    NSUInteger length = [source rangeOfString:@"</"].location - startLoc;
    
    NSString *newSource = [source substringWithRange:NSMakeRange(startLoc,length)];
    
    _source =  [NSString stringWithFormat:@"来自%@",newSource];
}

@end
