//
//  XXTextCell.h
//  XXVotePost
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXVoteTextModel.h"
typedef void (^voteOptionBlock)();

@interface XXVoteTextCell : UITableViewCell
//@property (nonatomic, strong) NSMutableString *textStr;
@property (nonatomic, strong) XXVoteTextModel *model;
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**  点击cell的动作 执行操作 */
- (void)voteOptionBlock:(voteOptionBlock)voteOptionBlock;
@end
