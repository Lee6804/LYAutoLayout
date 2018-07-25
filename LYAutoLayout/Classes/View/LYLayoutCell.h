//
//  LYLayoutCell.h
//  LYAutoLayout
//
//  Created by Lee on 2018/7/23.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYModel.h"

typedef void (^reloadTabBlock)(void);

@interface LYLayoutCell : UITableViewCell

@property(nonatomic,strong)LYModel *model;

@property(nonatomic,copy)reloadTabBlock reloadTabBlock;

+(CGFloat)cellTotalHeight:(LYModel *)model;

@end
