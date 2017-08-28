//
//  PSRankTableView.m
//  test
//
//  Created by pjpjpj on 2017/8/27.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import "PSRankTableView.h"
#import "PSRankTableViewCell.h"

@implementation PSRankTableView

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (void)initView {
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;

    [self registerNib:[UINib nibWithNibName:@"PSRankTableViewCell" bundle:nil] forCellReuseIdentifier:@"PSRankTableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tableDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSRankTableViewCell" forIndexPath:indexPath];
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row + 1];
    cell.nameLabel.text = _tableDataArray[indexPath.row][@"username"];
    cell.scoreLabel.text = _tableDataArray[indexPath.row][@"score"];
    return cell;
}

- (void)setTableDataArray:(NSArray *)tableDataArray {
    _tableDataArray = tableDataArray;
    [self reloadData];
}

@end
