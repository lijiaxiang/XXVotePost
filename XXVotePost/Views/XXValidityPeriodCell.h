//
//  XXValidityPeriodCell.h
//  XXVotePost
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXValidityPeriodModel.h"
typedef void (^validityPeriodBlock)();

@interface XXValidityPeriodCell : UITableViewCell
@property (nonatomic, strong) XXValidityPeriodModel *model;
+(instancetype)cellWithTableView:(UITableView *)tableView;
/**  点击cell的动作 执行操作 */
- (void)validityPeriodBlock:(validityPeriodBlock)validityPeriod;
@end
