//
//  loginViewController.m
//  test
//
//  Created by 裴骕 on 2017/8/19.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    
    self.view.backgroundColor = [UIColor blueColor];
    
    UILabel *LoginLabel = [[UILabel alloc] initWithFrame:CGRectMake((width - 210)/2, 100, 210, 50)];
    [self.view addSubview:LoginLabel];
    LoginLabel.text = @"登陆界面";
    LoginLabel.font = [UIFont systemFontOfSize:40];
    
    UIButton *rollbackBtn = [[UIButton alloc] initWithFrame:CGRectMake((width - 100)/2, height / 2 + 110, 100, 30)];
    [self.view addSubview:rollbackBtn];
    [rollbackBtn addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    rollbackBtn.backgroundColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    [rollbackBtn setTitle:@"回滚" forState:UIControlStateNormal];
    
}

- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
