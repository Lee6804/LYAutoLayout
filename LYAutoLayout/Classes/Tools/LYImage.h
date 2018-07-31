//
//  LYImage.h
//  LYAutoLayout
//
//  Created by Lee on 2018/7/23.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYImage : UIImage

- (UIImage *)imageWithCornerRadius:(CGFloat)radius;

/**
 获取单张图片的实际size
 
 @param singleSize 原始
 @return 结果
 */
+ (CGSize)getSingleSize:(CGSize)singleSize;

@end
