//
//  XXAddVoteTextCell.h
//  XXVotePost
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^addVoteTextCellBlock)();

@interface XXAddVoteTextCell : UITableViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**  点击cell的动作 执行操作 */
- (void)addVoteTextCellBlock:(addVoteTextCellBlock)voteTextCellBlock;
@end
