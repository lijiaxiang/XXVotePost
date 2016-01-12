//
//  XXTextViewCell.m
//  XXVotePost
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XXTextViewCell.h"
#import "XXTextView.h"

@interface XXTextViewCell()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet XXTextView *textView;


@end
@implementation XXTextViewCell
+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"XXTextViewCell";
    XXTextViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"XXTextViewCell" owner:nil options:nil]lastObject];
    if (cell == nil) {
        cell = [[XXTextViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
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
- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    self.model.textStr = textView.text.mutableCopy;
    return YES;
}
/** 关闭键盘通知 */
- (void)creatBaseViews{
    self.textView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(closeKboard) name:@"closeKboard" object:nil];}
- (void)closeKboard{
    NSLog(@"closeKboard");
    [self.textView resignFirstResponder];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.textView.placeholder = @"填写投票描述，让更多人参与投票";
}
/**
 *  监听文本输入框内部富文本的改变
 */
- (void)textViewDidChange:(UITextView *)textView{
    if (textView == self.textView) {
        if (textView.text.length > 50) {
            textView.text = [textView.text substringToIndex:50];
            //这里可以给提示
        }
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (textView == self.textView) {
        if (text.length == 0) return YES;
        
        NSInteger existedLength = textView.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = text.length;
        if (existedLength - selectedLength + replaceLength > 50) {
            //这里可以给提示
            return NO;
        }
    }
    return YES;
}
/** 赋值 */
- (void)setModel:(XXVoteTextModel *)model{
    _model = model;
    self.textView.text = model.textStr;
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
@end
