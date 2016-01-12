//
//  XXAddVoteTextCell.m
//  XXVotePost
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XXAddVoteTextCell.h"
@interface XXAddVoteTextCell()
@property (nonatomic, strong) addVoteTextCellBlock addVoteText;
@end
@implementation XXAddVoteTextCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"XXAddVoteTextCell";
    XXAddVoteTextCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XXAddVoteTextCell" owner:nil options:nil]lastObject];
    if (cell == nil) {
        cell = [[XXAddVoteTextCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    return cell;
}
- (IBAction)addVoteTextCellBtnClick:(id)sender {
    _addVoteText();
}
- (void)addVoteTextCellBlock:(addVoteTextCellBlock)voteTextCellBlock{
    _addVoteText = voteTextCellBlock;
}

@end
