//
//  XXTextFileCell.m
//  XXVotePost
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XXTextFileCell.h"
@interface XXTextFileCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFild;

@end
@implementation XXTextFileCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"XXTextFileCell";
    XXTextFileCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XXTextFileCell" owner:nil options:nil]lastObject];
    if (cell == nil) {
        cell = [[XXTextFileCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    return cell;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self creatBaseViews];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatBaseViews];
    }
    return self;
}
/** 当光标失去在本编辑框的焦点 也就会调用此方法 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.model.textStr = textField.text.mutableCopy;
    return YES;
}
/** 关闭键盘通知 */
- (void)creatBaseViews{
    self.textFild.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKboard) name:@"closeKboard" object:nil];}
- (void)closeKboard{
    NSLog(@"closeKboard");
    [self.textFild resignFirstResponder];
}
/** 赋值 */
- (void)setModel:(XXVoteTextModel *)model{
    _model = model;
    self.textFild.text = model.textStr;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [self.textFild addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField == self.textFild) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 30) {
            //这里可以给提示
            
            return NO;
        }
    }
    return YES;
}
/**
 *  监听文本输入框内部富文本的改变
 */
- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.textFild) {
        if (textField.text.length > 30) {
            textField.text = [textField.text substringToIndex:30];
            //这里可以给提示
        }
    }
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5);
    lineView.backgroundColor = [UIColor colorWithRed:224 / 255.0 green:224 / 255.0 blue:224 / 255.0 alpha:1];
    [self addSubview:lineView];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
