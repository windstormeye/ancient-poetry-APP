//
//  PSAnswerView.m
//  test
//
//  Created by 裴骕 on 2017/8/19.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import "PSAnswerView.h"

static int titleNum;

@implementation PSAnswerView {
    NSArray *_kButtArr;
    NSString *_kAnswerString;
    NSArray *_kOptionArr;
    UIButton *_kNextBtn;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initView];
}

- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    _kOptionArr = [@[] mutableCopy];
    titleNum = 0;
    
    // 获取当前按钮的显示数字
    [_button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_button4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _kButtArr = [[NSArray alloc] initWithObjects:_button1, _button2, _button3, _button4, nil];
    
    for (int i = 0; i< 4; i ++) {
        UIButton *btn = [_kButtArr objectAtIndex:i];
        btn.titleLabel.frame = CGRectMake((btn.frame.size.width - 200)/2, (btn.frame.size.height - 20)/2, 200, 20);
    }
    
    _kNextBtn = [[UIButton alloc] initWithFrame:CGRectMake((self.frame.size.width - 300) / 2, self.frame.size.height - 200, 300, 50)];
    [self addSubview:_kNextBtn];
    [_kNextBtn setTitle:@"下一题" forState:UIControlStateNormal];
    [_kNextBtn addTarget:self action:@selector(reloadView) forControlEvents:UIControlEventTouchUpInside];
    _kNextBtn.enabled = false;
    _kNextBtn.backgroundColor = [UIColor blueColor];
}

- (void)setViewDataArray:(NSArray *)viewDataArray {
    _viewDataArray = viewDataArray;
    [self reloadView];
}

- (void)reloadView {
    _kNextBtn.enabled = false;
    for (int i = 0; i < 4; i ++) {
        UIButton *tempBtn = [_kButtArr objectAtIndex:i];
        tempBtn.enabled = true;
        if ([tempBtn.titleLabel.text isEqualToString:_kAnswerString]) {
            [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    NSDictionary *dict = _viewDataArray[titleNum];
    _titleTextView.text = dict[@"title"];
    _kAnswerString = dict[@"answer"];
    _kOptionArr = dict[@"option"];
    
    NSMutableArray *numArr = [@[] mutableCopy];
    
    for (int i = 0; i < _kOptionArr.count; i++) {
        int radomNum = arc4random() % 4;
        
        while (true) {
            if ([numArr containsObject:@(radomNum)]) {
                radomNum = arc4random() % 4;
                if ([numArr containsObject:@(radomNum)]) {
                    continue;
                }
            } else {
                [numArr addObject:@(radomNum)];
                break;
            }
        }
        
        switch (radomNum) {
            case 0:
                _button1.titleLabel.text = _kOptionArr[i]; break;
            case 1:
                _button2.titleLabel.text = _kOptionArr[i]; break;
            case 2:
                _button3.titleLabel.text = _kOptionArr[i]; break;
            case 3:
                _button4.titleLabel.text = _kOptionArr[i]; break;
        }
    }
    
    titleNum ++;
}

- (void)btnClick:(UIButton *)sender {
    NSString *btnString = sender.titleLabel.text;
    if ([_kAnswerString isEqualToString:btnString]) {
        [sender setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        _kNextBtn.enabled = YES;
    } else {
        [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
}

@end
