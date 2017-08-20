//
//  PSAnswerView.h
//  test
//
//  Created by 裴骕 on 2017/8/19.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSAnswerView : UIView
@property (weak, nonatomic) IBOutlet UITextView *titleTextView;
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;

@property (nonatomic, strong) NSArray *viewDataArray;

@end
