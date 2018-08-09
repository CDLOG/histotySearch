//
//  HistorySearchCell.h
//  NST
//
//  Created by 陈乐杰 on 2018/8/7.
//  Copyright © 2018年 owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistorySearchModel.h"
extern NSString *const HistorySearchCellID;
@interface HistorySearchCell : UITableViewCell
-(void)setModel:(HistorySearchModel *)model;
@end
