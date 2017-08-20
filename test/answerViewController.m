//
//  AnswerViewController.m
//  test
//
//  Created by 裴骕 on 2017/8/19.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import "answerViewController.h"
#import <BmobSDK/Bmob.h>
#import "PSAnswerTableView.h"

@interface answerViewController ()

@end

@implementation answerViewController {
    UITextView *_kTitleTextView;
    UIView *_kBarView;
    NSMutableArray *_kTitleArr;
    PSAnswerTableView *_kTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _kTitleArr = [@[] mutableCopy];
    
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor blackColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 30, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"古诗部分";
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _kTableView = [[PSAnswerTableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:_kTableView];

    [self getDataWithBmob];
}

- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getDataWithBmob {
    [SVProgressHUD showWithStatus:@"请等待..."];
    BmobQuery   *bquery = [BmobQuery queryWithClassName:@"Answer_table"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for (BmobObject *obj in array) {
            NSMutableDictionary *dict = [@{} mutableCopy];
            dict[@"title"] = [obj objectForKey:@"title"];
            dict[@"answer"] = [obj objectForKey:@"rightAnswer"];
            NSMutableArray *optionArr = [@[] mutableCopy];
            for (int i = 1; i <= 3; i ++) {
                NSString *str = [NSString stringWithFormat:@"answer%d", i];
                [optionArr addObject:[obj objectForKey:str]];
            }
            [optionArr addObject:[obj objectForKey:@"rightAnswer"]];
            dict[@"option"] = optionArr;
            [_kTitleArr addObject:dict];
        }
        [SVProgressHUD dismiss];
        _kTableView.tableViewDataSource = _kTitleArr;
    }];
}

// 修改状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
