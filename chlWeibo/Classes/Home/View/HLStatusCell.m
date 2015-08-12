//
//  HLStatusCell.m
//  chlWeibo
//  微博自定义cell
//  Created by chlin7 on 15/8/8.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import "HLStatusCell.h"
#import "HLStatus.h"
#import "HLStatusFrame.h"
#import "HLUser.h"
#import "UIImageView+WebCache.h"

@interface HLStatusCell ()

/**
 每条微博的背景View
 */
@property(nonatomic,weak)UIImageView *topView;
/**
 头像
 */
@property(nonatomic,weak)UIImageView *iconView;
/**
 会员标志
 */
@property(nonatomic,weak)UIImageView *vipView;
/**
 配图
 */
@property(nonatomic,weak)UIImageView *photoView;
/**
 昵称
 */
@property(nonatomic,weak)UILabel *nameLabel;
/**
 时间
 */
@property(nonatomic,weak)UILabel *timeLabel;
/**
 来源
 */
@property(nonatomic,weak)UILabel *sourceLabel;
/**
 正文内容
 */
@property(nonatomic,weak)UILabel *contentLabel;

/**
 被转发微博的背景view
 */
@property(nonatomic,weak)UIImageView *retweetView;
/**
 被转发微博的作者昵称
 */
@property(nonatomic,weak)UILabel *retweetNameLabel;
/**
 被转发微博的正文内容
 */
@property(nonatomic,weak)UILabel *retweetContentLabel;
/**
 被转发微博的配图
 */
@property(nonatomic,weak)UIImageView *retweetPhotoView;

/**
 微博的工具条view
 */
@property(nonatomic,weak)UIImageView *statusToolBarView;
@end

@implementation HLStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"status";
    HLStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HLStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //1.0添加原创微博内部的字控件
        [self setupOriginalSubViews];
        //2.0添加被转发微博内部的字控件
        [self setupRetweetSubViews];
        
        //3.0添加微博工具条的字控件
        [self setupOStatusTool];
    }
    return self;
}
/**
 *  添加原创微博内部的字控件
 */
-(void)setupOriginalSubViews{
    //1.最外边父控件
    UIImageView *topView = [[UIImageView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    //2.头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self.topView addSubview:iconView];
    self.iconView = iconView;
    //3.会员
    UIImageView *vipView = [[UIImageView alloc] init];
    [self.topView addSubview:vipView];
    self.vipView = vipView;
    //4.配图
    UIImageView *photoView = [[UIImageView alloc] init];
    [self.topView addSubview:photoView];
    self.photoView = photoView;
    //5.昵称
    UILabel *nameLabel = [[UILabel alloc] init];
    [self.topView addSubview:nameLabel];
    nameLabel.font = HLStatusNameLabelFont;
    self.nameLabel = nameLabel;
    //6.时间
    UILabel *timeLabel = [[UILabel alloc] init];
    [self.topView addSubview:timeLabel];
    timeLabel.font = HLStatusTimeLabelFont;
    self.timeLabel = timeLabel;
    //7.来源
    UILabel *sourceLabel = [[UILabel alloc] init];
    [self.topView addSubview:sourceLabel];
    sourceLabel.font = HLStatusSourceLabelFont;
    self.sourceLabel = sourceLabel;
    //8.正文
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.numberOfLines = 0;
    [self.topView addSubview:contentLabel];
    contentLabel.font = HLStatusContentLabelFont;
    self.contentLabel = contentLabel;
}
/**
 *  添加被转发微博内部的字控件
 */
-(void)setupRetweetSubViews{
    //1.被转发微博的view
    UIImageView *retweetView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    //2.被转发微博作者的昵称
    UILabel *retweetNameLabel = [[UILabel alloc] init];
    retweetNameLabel.font = HLStatusRetweetNameLabelFont;
    [self.retweetView addSubview:retweetNameLabel];
    self.retweetNameLabel = retweetNameLabel;
    //3.被转发微博的正文
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.font = HLStatusRetweetContentLabelFont;
    retweetContentLabel.numberOfLines = 0;
    [self.retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    //4.被转发微博的配图
    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
    [self.topView addSubview:retweetPhotoView];
    self.retweetPhotoView = retweetPhotoView;
}
/**
 *  添加微博工具条的字控件
 */
-(void)setupOStatusTool{
    //1.微博工具条view
    UIImageView *statusToolBarView = [[UIImageView alloc] init];
    [self.contentView addSubview:statusToolBarView];
    self.statusToolBarView = statusToolBarView;
}
/**
 *  传递数据模型
 */
-(void)setStatusFrame:(HLStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    //1.原创
    [self setupOriginalData];
    //2.转发
    [self setupRetweetData];
}
/**
 *  设置原创微博的数据
 */
-(void)setupOriginalData{
    HLStatus * status= self.statusFrame.status;
    HLUser *user = status.user;
    
    //1.topView
    self.topView.frame = self.statusFrame.topViewFrame;
    
    //2.头像
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewFrame;
    
    //3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelFrame;
    
    //4.vip
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageNamed:@"common_icon_membership"];
        self.vipView.frame = self.vipView.frame;
    }else{
        self.vipView.hidden = YES;
    }
    //5.时间
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = self.statusFrame.timeLabelFrame;
    //6.来源
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = self.statusFrame.sourceLabelFrame;
    
    //7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelFrame;
    
    //8.配图
    if (status.thumbnail_pic) {
        self.photoView.hidden = NO;
        self.photoView.frame = self.statusFrame.photoViewFrame;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    }else{
        self.photoView.hidden = YES;
    }
}
/**
 *  设置转发微博的数据
 */
-(void)setupRetweetData{
    HLStatus * retweetStatus= self.statusFrame.status.retweeted_status;
    HLUser *retweetStatusUser = retweetStatus.user;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        //1.转发微博的父控件
        self.retweetView.frame = self.statusFrame.retweetViewFrame;
        //2.转发微博的昵称
        self.retweetNameLabel.text = retweetStatusUser.name;
        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelFrame;
        //3.转发微博的正文
        self.retweetContentLabel.text = retweetStatus.text;
        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelFrame;
        //4.转发微博的配图
        if (retweetStatus.thumbnail_pic) {
            self.retweetPhotoView.hidden = NO;
            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewFrame;
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        }else{
            self.retweetPhotoView.hidden = YES;
        }
    }else{
        self.retweetView.hidden = YES;
    }


}

@end
