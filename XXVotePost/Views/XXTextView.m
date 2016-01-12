//
//  XXAddVoteTextCell.m
//  XXVotePost
//
//  Created by apple on 16/1/9.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "XXTextView.h"
@interface XXTextView()
@property (nonatomic, weak) UILabel *placeholderLabel;

@end

@implementation XXTextView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
    self.placeholder = @"填写投票描述，让更多人参与投票";
    //添加一个placeholder的label
    UILabel *placeholderLabel = [[UILabel alloc] init];
    placeholderLabel.textColor = [UIColor lightGrayColor];
    placeholderLabel.numberOfLines = 0;
    [self addSubview:placeholderLabel];
    
    self.placeholderLabel = placeholderLabel;
    
    self.font = [UIFont systemFontOfSize:15];
    
    //通知方式来监听TextView的文字变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];

    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.placeholder = @"填写投票描述，让更多人参与投票";
        //添加一个placeholder的label
        UILabel *placeholderLabel = [[UILabel alloc] init];
        placeholderLabel.textColor = [UIColor lightGrayColor];
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        
        self.placeholderLabel = placeholderLabel;
        
        self.font = [UIFont systemFontOfSize:15];
        
        //通知方式来监听TextView的文字变化
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}
//设置字体大小
-(void)setFont:(UIFont *)font{
    [super setFont:font];
    self.placeholderLabel.font = font;
}
//显示不显示placeholder
-(void)textViewDidChange:(NSNotification *)notif{
    self.placeholderLabel.hidden = self.text.length > 0;
}
//设置文字
-(void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //计算文字大小
    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, MAXFLOAT);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSFontAttributeName] = self.font;
    //根据placeholder返回一个高度  传的参数有字体大小
    CGSize titleSize = [self.placeholder boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    
    //设置label 的frm
    self.placeholderLabel.frame = CGRectMake(5, 8, titleSize.width, titleSize.height);
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
