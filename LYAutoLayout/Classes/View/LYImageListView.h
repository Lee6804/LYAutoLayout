//
//  LYImageListView.h
//  LYAutoLayout
//
//  Created by Lee on 2018/7/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYModel.h"

@interface LYImageListView : UIView

@property(nonatomic,strong)LYModel *model;

// 获取视图高度
+ (CGFloat)imageListHeight:(LYModel *)model;

@end

@interface LYImageView : UIImageView

// 点击小图
@property (nonatomic, copy) void (^tapSmallView)(LYImageView *imageView);

@end
