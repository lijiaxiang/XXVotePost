//
//  XXVoteOptionCell.m
//  XXVotePost
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XXVoteOptionCell.h"

@implementation XXVoteOptionCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"XXVoteOptionCell";
    XXVoteOptionCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XXVoteOptionCell" owner:nil options:nil]lastObject];
    if (cell == nil) {
        cell = [[XXVoteOptionCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    return cell;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)imageBtnClick:(id)sender {
    NSLog(@"imageBtnClick");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"imageVote" object:nil];
}
- (IBAction)textBtnClick:(id)sender {
    NSLog(@"textBtnClick");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"textVote" object:nil];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5);
    lineView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self addSubview:lineView];
}

@end
