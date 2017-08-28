//
//  PSRankTableView.h
//  test
//
//  Created by pjpjpj on 2017/8/27.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PSRankTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tableDataArray;

@end
