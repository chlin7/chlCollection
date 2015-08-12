//
//  HLStatusCell.h
//  chlWeibo
//
//  Created by chlin7 on 15/8/8.
//  Copyright (c) 2015年 chlin7. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HLStatusFrame;
@interface HLStatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic,strong) HLStatusFrame *statusFrame;

@end
