//
//  loginViewController.m
//  test
//
//  Created by 裴骕 on 2017/8/19.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwdTxt;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;

@end

@implementation loginViewController {
    UIView *_kBarView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _kBarView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:_kBarView];
    _kBarView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 80)/2, 30, 80, 20)];
    [_kBarView addSubview:titleLabel];
    titleLabel.text = @"用户管理";
    titleLabel.textColor = [UIColor whiteColor];
    
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 30, 30)];
    [_kBarView addSubview:leftButton];
    [leftButton addTarget:self action:@selector(rollbackBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    self.view.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)rollbackBtnClick {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (IBAction)loginBtnClick:(id)sender {
    [SVProgressHUD showWithStatus:@"请稍等..."];
    if ([self.loginBtn.titleLabel.text isEqualToString:@"登录"]) {
        [BmobUser loginInbackgroundWithAccount:_nameTxt.text andPassword:_passwdTxt.text block:^(BmobUser *user, NSError *error) {
            if (user) {
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                NSNotification *notification = [NSNotification notificationWithName:@"loginNo" object:nil userInfo:@{@"isLogin":@true}];
                [[NSNotificationCenter defaultCenter] postNotification:notification];
                [self rollbackBtnClick];
            } else {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
            }
        }];
    } else {
        BmobUser *bUser = [[BmobUser alloc] init];
        [bUser setUsername:_nameTxt.text];
        [bUser setPassword:_passwdTxt.text];
        [bUser signUpInBackgroundWithBlock:^ (BOOL isSuccessful, NSError *error){
            if (isSuccessful){
                [BmobUser loginInbackgroundWithAccount:_nameTxt.text andPassword:_passwdTxt.text block:^(BmobUser *user, NSError *error) {
                    if (user) {
                        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
                        NSNotification *notification = [NSNotification notificationWithName:@"loginNo" object:nil userInfo:@{@"isLogin":@true}];
                        [[NSNotificationCenter defaultCenter] postNotification:notification];
                        [self rollbackBtnClick];
                    } else {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
                    }
                }];
            } else {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@", error]];
            }
        }];
    }
}

- (IBAction)signInBtnClick:(id)sender {
    if ([self.signBtn.titleLabel.text isEqualToString:@"没有账号？前往注册"]) {
        [self.signBtn setTitle:@"已有账号，前往登录" forState:UIControlStateNormal];
        [self.loginBtn setTitle:@"注册" forState:UIControlStateNormal];
        self.loginBtn.backgroundColor = [UIColor orangeColor];
    } else {
        [self.signBtn setTitle:@"没有账号？前往注册" forState:UIControlStateNormal];
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        self.loginBtn.backgroundColor = [UIColor colorWithRed:15/255.0 green:127/255.0 blue:1 alpha:1];
    }
}

@end
