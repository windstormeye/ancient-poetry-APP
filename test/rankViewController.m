//
//  rankViewController.m
//  test
//
//  Created by 裴骕 on 2017/8/19.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import "rankViewController.h"
#import "PSRankTableView.h"

@interface rankViewController ()

@end

@implementation rankViewController {
    PSRankTableView *_kTableView;
    UIView *_kBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor blackColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 30, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"排行榜";
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    _kTableView = [PSRankTableView new];
    [self.view addSubview:_kTableView];
    
    [self getDataFromBmob];
}


- (void)getDataFromBmob {
    BmobQuery   *bquery = [BmobUser query]; //用户表
    [bquery orderByDescending:@"score"];
    [SVProgressHUD showWithStatus:@"请稍等..."];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        NSMutableArray *userArr = [@[] mutableCopy];
        for (BmobObject *obj in array) {
            NSMutableDictionary *dict = [@{} mutableCopy];
            dict[@"username"] = [obj objectForKey:@"username"];
            dict[@"score"] = [obj objectForKey:@"score"];
            [userArr addObject:dict];
        }
        [SVProgressHUD dismiss];
        [self arrSort:userArr];
        _kTableView.tableDataArray = userArr;
    }];
}

- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)arrSort:(NSArray *)dataArr {
    int tempNum[100];
    for (int i = 0; i < dataArr.count; i ++) {
        NSString *str = [dataArr objectAtIndex:i][@"score"];
        int tempInt = (int)[str integerValue];
        tempNum[i] =tempInt;
    }
    
    for (int i = 0; i < dataArr.count; i++) {
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
