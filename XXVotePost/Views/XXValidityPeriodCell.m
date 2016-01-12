//
//  XXValidityPeriodCell.m
//  XXVotePost
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XXValidityPeriodCell.h"
@interface XXValidityPeriodCell()
/** 有效期lable */
@property (weak, nonatomic) IBOutlet UILabel *validityLable;
@property (nonatomic, strong) validityPeriodBlock validityPeriod;
@end
@implementation XXValidityPeriodCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"XXValidityPeriodCell";
    XXValidityPeriodCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XXValidityPeriodCell" owner:nil options:nil]lastObject];
    if (cell == nil) {
        cell = [[XXValidityPeriodCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    return cell;
}

- (void)setModel:(XXValidityPeriodModel *)model{
    _model = model;
    switch (model.validityPeriodType) {
        case 0:
            self.validityLable.text = @"一天";
            break;
        case 1:
            self.validityLable.text = @"一周";
            break;
        case 2:
            self.validityLable.text = @"一个月";
            break;
            
        default:
            break;
    }
}









- (IBAction)cellAllBtnClick:(id)sender {
    _validityPeriod();
}
- (void)validityPeriodBlock:(validityPeriodBlock)validityPeriod{
    _validityPeriod = validityPeriod;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5);
    lineView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self addSubview:lineView];
}
@end
