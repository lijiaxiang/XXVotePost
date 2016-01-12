//
//  XXTextViewCell.h
//  XXVotePost
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXVoteTextModel.h"

@interface XXTextViewCell : UITableViewCell
@property (nonatomic, strong) XXVoteTextModel *model;
+(instancetype)cellWithTableView:(UITableView *)tableView;
@end
