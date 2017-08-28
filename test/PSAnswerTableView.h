//
//  PSAnswerTableView.h
//  test
//
//  Created by pjpjpj on 2017/8/20.
//  Copyright © 2017年 裴骕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PSAnswerTableViewDelegate <NSObject>

- (void)finishAnswerActivity:(int)score;

@end

@interface PSAnswerTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
  
@property (nonatomic, strong) NSArray *tableViewDataSource;
@property (nonatomic, weak) id<PSAnswerTableViewDelegate> tableDelegate;
@end
