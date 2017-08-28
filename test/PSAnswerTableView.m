//
//  PSAnswerTableView.m
//  test
//
//  Created by pjpjpj on 2017/8/20.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import "PSAnswerTableView.h"
#import "PSAnswerTableViewCell.h"

static int titleNum;
static int score;

@implementation PSAnswerTableView

- (id)init {
    self = [super init];
    [self initView];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    [self initView];
    return self;
}

- (void)initView {
    titleNum = 0;
    score = 0;
    self.backgroundColor = [UIColor whiteColor];
    self.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    self.delegate = self;
    self.dataSource = self;
    [self registerNib:[UINib nibWithNibName:@"PSAnswerTableViewCell" bundle:nil] forCellReuseIdentifier:@"PSAnswerTableViewCell"];
    self.tableFooterView = [UIView new];
}

- (void)setTableViewDataSource:(NSArray *)tableViewDataSource {
    _tableViewDataSource = tableViewDataSource;
    [self reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    [headView addSubview:textView];
    textView.text = _tableViewDataSource[titleNum][@"title"];
    textView.font = [UIFont systemFontOfSize:18];
    return headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PSAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PSAnswerTableViewCell" forIndexPath:indexPath];
    cell.cellTitleLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
    cell.cellTitleLabel.text = _tableViewDataSource[titleNum][@"option"][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PSAnswerTableViewCell *cell = [tableView  cellForRowAtIndexPath:indexPath];
    cell.selected = false;
    NSString *answerString = _tableViewDataSource[titleNum][@"answer"];
    if ([answerString isEqualToString:cell.textLabel.text]) {
        titleNum ++;
        score += 1;
        if (titleNum == _tableViewDataSource.count) {
            [[BmobUser currentUser] setObject:[NSString stringWithFormat:@"%d", titleNum] forKey:@"score"];
            [[BmobUser currentUser] updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                if (isSuccessful) {
                    [_tableDelegate finishAnswerActivity:score];
                } else {
                    NSLog(@"error %@",[error description]);
                }
            }];
        } else {
            [self reloadData];
        }
    } else {
        score --;
        cell.cellTitleLabel.textColor = [UIColor redColor];
    }
}


@end
