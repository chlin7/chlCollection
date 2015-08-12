//
//  HLStatusFrame.m
//  chlWeibo
//
//  Created by chlin7 on 15/8/9.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLStatusFrame.h"
#import "HLStatus.h"
#import "HLUser.h"

@implementation HLStatusFrame

/**
 *  获得微博模型数据后，就
 *
 *  @param status cell的数据
 */
-(void)setStatus:(HLStatus *)status{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = SCREEN_WIDTH;
    
    //1.topview
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    
    //2.头像
    CGFloat iconViewWH = 35;
    CGFloat iconViewX = HLStatusCellBorder;
    CGFloat iconViewY = HLStatusCellBorder;
    _iconViewFrame = CGRectMake(iconViewX, iconViewY, iconViewWH, iconViewWH);
    
    //3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewFrame) + HLStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [status.user.name sizeWithFont:HLStatusNameLabelFont];
    _nameLabelFrame = (CGRect){{nameLabelX,nameLabelY},nameLabelSize};
    
    //4.会员图标
    if (status.user.isVip) {
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelFrame) + HLStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        _iconViewFrame = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    //5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelFrame) + HLStatusCellBorder;
    CGSize timeLabelSize = [status.created_at sizeWithFont:HLStatusTimeLabelFont];
    _timeLabelFrame = (CGRect){{timeLabelX,timeLabelY},timeLabelSize};
    
    //6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelFrame) + HLStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:HLStatusSourceLabelFont];
    _sourceLabelFrame = (CGRect){{sourceLabelX,sourceLabelY},sourceLabelSize};
    
    //7.正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_timeLabelFrame), CGRectGetMaxY(_iconViewFrame)) +HLStatusCellBorder;
    //需要限制宽度
    CGFloat contentLabelMaxW = topViewW - 2*HLStatusCellBorder;
    CGSize contentLabelSize = [status.source sizeWithFont:HLStatusContentLabelFont constrainedToSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelFrame = (CGRect){{contentLabelX,contentLabelY},contentLabelSize};

    //8.配图
    if (status.thumbnail_pic) {
        CGFloat photoViewX = contentLabelX;
        CGFloat photoViewY = CGRectGetMaxY(_contentLabelFrame) + HLStatusCellBorder;
        CGFloat photoViewWH = 70;
        _photoViewFrame = CGRectMake(photoViewX, photoViewY, photoViewWH, photoViewWH);
    }else{//没有配图
        
    }
    
    if (status.retweeted_status) {//有转发
        //9.被转发微博
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelFrame) + HLStatusCellBorder;
        CGFloat retweetViewH = 0;
        
        //10.被转发微博的昵称
        CGFloat retweetNameLabelX = HLStatusCellBorder;
        CGFloat retweetNameLabelY = HLStatusCellBorder;
        CGSize retweetNameLabelSize = [status.retweeted_status.user.name sizeWithFont:HLStatusRetweetNameLabelFont];
        _retweetNameLabelFrame = (CGRect){{retweetNameLabelX,retweetNameLabelY},retweetNameLabelSize};
        //11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelFrame)+HLStatusCellBorder;
        //需要限制宽度
        CGFloat retweetContentLabelMaxW = retweetViewW - 2*HLStatusCellBorder;
        CGSize retweetContentLabelSize = [status.retweeted_status.text sizeWithFont:HLStatusRetweetContentLabelFont constrainedToSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelFrame = (CGRect){{retweetContentLabelX,retweetContentLabelY},retweetContentLabelSize};
        //12.被转发微博的配图
        if (status.retweeted_status.thumbnail_pic) {
            CGFloat retweetPhotoViewX = retweetContentLabelX;
            CGFloat retweetPhotoViewY = CGRectGetMaxY(_retweetContentLabelFrame) + HLStatusCellBorder;
            CGFloat retweetPhotoViewWH = 70;
            _retweetPhotoViewFrame = CGRectMake(retweetPhotoViewX, retweetPhotoViewY, retweetPhotoViewWH, retweetPhotoViewWH);
            
            retweetViewH = CGRectGetMaxY(_retweetPhotoViewFrame);
        }else{
            retweetViewH = CGRectGetMaxY(_retweetContentLabelFrame);
        }
        retweetViewH += HLStatusCellBorder;
        _retweetViewFrame = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        topViewH = CGRectGetMaxY(_retweetViewFrame);
    }else{//没有转发
        if (status.thumbnail_pic) {//有图
            topViewH = CGRectGetMaxY(_photoViewFrame);
        }else{//无图
            topViewH = CGRectGetMaxY(_contentLabelFrame);
        }
    }
    
    topViewH += HLStatusCellBorder;
    //设置topView的frame
    _topViewFrame = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    //cell的高度
    _cellHeight = topViewH;
}

@end
