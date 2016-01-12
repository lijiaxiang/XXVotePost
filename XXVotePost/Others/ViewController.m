//
//  ViewController.m
//  XXVotePost
//
//  Created by apple on 16/1/7.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "XXVotePost.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"XXVotePost" bundle:nil];
    XXVotePost *cdVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:cdVc animated:YES];
}

@end
