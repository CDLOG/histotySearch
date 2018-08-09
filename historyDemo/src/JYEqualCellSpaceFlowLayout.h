//
//  JYEqualCellSpaceFlowLayout.h
//  UICollectionViewDemo
//
//  Created by 飞迪1 on 2017/10/13.
//  Copyright © 2017年 CHC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FlowAlignType){
    FlowAlignWithLeft,
    FlowAlignWithCenter,
    FlowAlignWithRight
};
@interface JYEqualCellSpaceFlowLayout : UICollectionViewFlowLayout
//两个Cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign)FlowAlignType cellType;

-(instancetype)initWthType : (FlowAlignType)cellType;
//全能初始化方法 其他方式初始化最终都会走到这里
-(instancetype)initWithType:(FlowAlignType) cellType betweenOfCell:(CGFloat)betweenOfCell;

@end
