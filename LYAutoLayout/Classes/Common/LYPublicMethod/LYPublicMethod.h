//
//  LYPublicMethod.h
//  LYAutoLayout
//
//  Created by Lee on 2018/7/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYPublicMethod : NSObject

/**
 根据内容获取size

 @param lessWidth 内容显示的长度
 @param str 要计算的内容
 @return size
 */
+ (CGRect)LY_CUSTOME_METHOD(getSize):(CGFloat)lessWidth str:(NSString *)str;


/**
 获取本地json文件，并返回为字典形式

 @param name json文件名
 @return 字典
 */
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;

@end
