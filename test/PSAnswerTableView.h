//
//  PSAnswerTableView.h
//  test
//
//  Created by pjpjpj on 2017/8/20.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSAnswerTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableViewDataSource;

@end
