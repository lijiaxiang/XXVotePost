//
//  XXVotePost.m
//  XXVotePost
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XXVotePost.h"
#import "XXVoteTextCell.h"
#import "XXTextFileCell.h"
#import "XXTextViewCell.h"
#import "XXVoteOptionCell.h"
#import "XXVoteTextModel.h"
#import "XXAddVoteTextCell.h"
#import "XXValidityPeriodCell.h"
#import "XXValidityPeriodModel.h"

typedef NS_ENUM(NSUInteger, voteOptionType) {
    voteOptionTypeImage,//图片投票贴
    voteOptionTypeText  //文字投票贴
};
@interface XXVotePost ()<UIActionSheetDelegate>
/**
 *  投票类型
 */
@property (nonatomic, assign) voteOptionType actionType;
/**
 *  标题内容模型
 */
@property (nonatomic, strong) XXVoteTextModel *titleTextModel;
/**
 *  描述内容模型
 */
@property (nonatomic, strong) XXVoteTextModel *contentTextModel;
/**
 *  图片选项模型数组
 */
@property (nonatomic, strong) NSMutableArray *array1;
/**
 *  文字选项模型数组
 */
@property (nonatomic, strong) NSMutableArray *array2;
/**
 *  有效期模型
 */
@property (nonatomic, strong) XXValidityPeriodModel *validityPeriodmodel;

@property (nonatomic, strong) UIActionSheet *actionSheet;
@end

@implementation XXVotePost

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actionType = voteOptionTypeText;


    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256)) / 255.0 green:((float)arc4random_uniform(256)) / 255.0 blue:((float)arc4random_uniform(256)) / 255.0 alpha:1.0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageVote) name:@"imageVote" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textVote) name:@"textVote" object:nil];
    
    /** 发表按钮 进行网络请求 */
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 22)];
    [rightBtn setTitle:@"发表" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

/** 切换投票列表 */
- (void)imageVote{
    self.actionType = voteOptionTypeImage;
    [self.tableView reloadData];
}
- (void)textVote{
    self.actionType = voteOptionTypeText;
    NSLog(@"%@",self.array2);
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.actionType == voteOptionTypeImage){
        return 3 + self.array1.count + 2;
    }else if (self.actionType == voteOptionTypeText) {
        return 3 + self.array2.count + 2;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        XXTextFileCell *cell = [XXTextFileCell cellWithTableView:tableView];
        cell.model = self.titleTextModel;
        return cell;
    }else if (indexPath.row == 1){
        XXTextViewCell *cell = [XXTextViewCell cellWithTableView:tableView];
        cell.model = self.contentTextModel;
        return cell;
    }else if (indexPath.row == 2){
        XXVoteOptionCell *cell = [XXVoteOptionCell cellWithTableView:tableView];
        return cell;
    }
    if (indexPath.row == 6) {
        
    }
    //判断显示添加选项行以及投票有效期
    if(self.actionType == voteOptionTypeImage){
        if (indexPath.row == 3 + self.array1.count) {
            XXAddVoteTextCell *cell = [XXAddVoteTextCell cellWithTableView:tableView];
            [cell addVoteTextCellBlock:^{
                XXVoteTextModel *model = [XXVoteTextModel new];
                [self.array1 addObject:model];
                [self.tableView reloadData];
                NSLog(@"添加选项行");
            }];
            return cell;
        }else if(indexPath.row == 4 + self.array1.count){
            XXValidityPeriodCell *cell = [XXValidityPeriodCell cellWithTableView:tableView];
            cell.model = self.validityPeriodmodel;
            [cell validityPeriodBlock:^{
                NSLog(@"你点击了投票有效期");
                [self popActionSheet];
            }];
            return cell;
        }
    }else if (self.actionType == voteOptionTypeText) {
        if (indexPath.row == 3 + self.array2.count) {
            XXAddVoteTextCell *cell = [XXAddVoteTextCell cellWithTableView:tableView];
            [cell addVoteTextCellBlock:^{
                XXVoteTextModel *model = [XXVoteTextModel new];
                [self.array2 addObject:model];
                [self.tableView reloadData];
                NSLog(@"添加选项行");
            }];
            return cell;
        }else if(indexPath.row == 4 + self.array2.count){
            XXValidityPeriodCell *cell = [XXValidityPeriodCell cellWithTableView:tableView];
            cell.model = self.validityPeriodmodel;
            [cell validityPeriodBlock:^{
                NSLog(@"你点击了投票有效期");
                [self popActionSheet];
            }];
            return cell;
        }
    }
    
    XXVoteTextCell *cell = [XXVoteTextCell cellWithTableView:tableView];
    if(self.actionType == voteOptionTypeImage){
        int row = indexPath.row - 3;
        XXVoteTextModel *model = self.array1[row];
        
        cell.model = model;
        [cell voteOptionBlock:^{
            [self.array1 removeObjectAtIndex:row];
            [self.tableView reloadData];
            NSLog(@"%d",row);
        }];
    }else if (self.actionType == voteOptionTypeText) {
        int row = indexPath.row - 3;
        XXVoteTextModel *model = self.array2[row];
        
        cell.model = model;
        [cell voteOptionBlock:^{
            [self.array2 removeObjectAtIndex:row];
            [self.tableView reloadData];
            NSLog(@"%d",row);
        }];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 37;
    }else if (indexPath.row == 1){
        return 150;
    }else if (indexPath.row == 2){
        return 44;
    }
    if(self.actionType == voteOptionTypeImage){
        if (indexPath.row == 3 + self.array1.count) {
            return 54;
        }else if(indexPath.row == 4 + self.array1.count){
            return 44;
        }
    }else if (self.actionType == voteOptionTypeText) {
        if (indexPath.row == 3 + self.array2.count) {
            return 54;
        }else if(indexPath.row == 4 + self.array2.count){
            return 44;
        }
    }
    NSLog(@"%d",indexPath.row);
    return 33;
}
/** 弹出底部有效期选项 */
- (void)popActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"投票有效期"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"一天", @"一周", @"一个月", nil];
    self.actionSheet = actionSheet;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            self.validityPeriodmodel.validityPeriodType = validityPeriodOneDay;
            [self.tableView reloadData];
            break;
        case 1:
            self.validityPeriodmodel.validityPeriodType = validityPeriodOneWeek;
            [self.tableView reloadData];
            break;
        case 2:
            self.validityPeriodmodel.validityPeriodType = validityPeriodOneMonth;
            [self.tableView reloadData];
            break;
            
        default:
            break;
    }
    NSLog(@"%d",buttonIndex);
}
/** 发送收回键盘统一指令 */
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"123");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"closeKboard" object:nil];
}
#warning 设置你的网络请求
- (void)rightBtnClick{
    /** 用来判断是那种投票贴 */
    if (self.actionType == voteOptionTypeImage) {
        NSLog(@"%@__\n%@__\n%@__\n%d__",self.titleTextModel.textStr,self.contentTextModel.textStr,self.array1,self.validityPeriodmodel.validityPeriodType);
    }else if(self.actionType == voteOptionTypeText){
        NSLog(@"%@__\n%@__\n%@__\n%d__",self.titleTextModel.textStr,self.contentTextModel.textStr,self.array2,self.validityPeriodmodel.validityPeriodType);
    }
}



#pragma mark - lazy
- (XXVoteTextModel *)contentTextModel{
    if (_contentTextModel == nil) {
        XXVoteTextModel *model = [XXVoteTextModel new];
        _contentTextModel = model;
    }
    return _contentTextModel;
}
- (XXVoteTextModel *)titleTextModel{
    if (_titleTextModel == nil) {
        XXVoteTextModel *model = [XXVoteTextModel new];
        _titleTextModel = model;
    }
    return _titleTextModel;
}
- (NSMutableArray *)array1{
    if (_array1 == nil) {
        NSMutableArray *arrM = [NSMutableArray new];
        for (int i = 0; i < 2; i++) {
            NSMutableString *str = [NSMutableString stringWithString:@"123"];
            XXVoteTextModel *model = [XXVoteTextModel new];
            model.textStr = str;
            [arrM addObject:model];
        }
        _array1 = arrM;
    }
    return _array1;
}
- (NSMutableArray *)array2{
    if (_array2 == nil) {
        NSMutableArray *arrM = [NSMutableArray new];
        for (int i = 0; i < 3; i++) {
            NSMutableString *str = [NSMutableString stringWithString:@""];
            XXVoteTextModel *model = [XXVoteTextModel new];
            model.textStr = str;
            [arrM addObject:model];
        }
        _array2 = arrM;
    }
    return _array2;
}
- (XXValidityPeriodModel *)validityPeriodmodel{
    if (_validityPeriodmodel == nil) {
        XXValidityPeriodModel *model = [XXValidityPeriodModel new];
        _validityPeriodmodel = model;
    }
    return _validityPeriodmodel;
}
@end
