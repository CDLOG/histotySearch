//
//  HistorySearchCell.m
//  NST
//
//  Created by 陈乐杰 on 2018/8/7.
//  Copyright © 2018年 owner. All rights reserved.
//

#import "HistorySearchCell.h"
#define  Font_System_Regular(_size) [UIFont systemFontOfSize:_size]
NSString *const HistorySearchCellID = @"HistorySearchCell";
@interface HistorySearchCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *typeLable;

@end

@implementation HistorySearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLable.font = Font_System_Regular(16);
    self.titleLable.textAlignment = NSTextAlignmentLeft;
    
    self.typeLable.font = Font_System_Regular(11);
    self.typeLable.textAlignment = NSTextAlignmentCenter;
    
    [self.typeLable.layer setMasksToBounds:YES];
    [self.typeLable.layer setCornerRadius:5.0];
    
    
}

-(void)setModel:(HistorySearchModel *)model{
    self.titleLable.text = model.title;
    switch (model.type) {
        case HistorySearchSuplly:
            self.typeLable.hidden = YES;
            break;
        case HistorySearchMerchant:
            self.typeLable.text = @"农商户";
            self.typeLable.hidden = NO;
            break;
        case HistorySearchNeed:
            self.typeLable.text = @"需求";
            self.typeLable.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
