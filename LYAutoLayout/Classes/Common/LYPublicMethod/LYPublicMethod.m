//
//  LYPublicMethod.m
//  LYAutoLayout
//
//  Created by Lee on 2018/7/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYPublicMethod.h"

@implementation LYPublicMethod

#pragma mark - 根据内容获取size
+ (CGRect)LY_CUSTOME_METHOD(getSize):(CGFloat)lessWidth str:(NSString *)str{
    CGRect labelSize = [str boundingRectWithSize:CGSizeMake(MainWidth - lessWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] context:nil];
    return labelSize;
}


#pragma mark -  获取本地json文件，并返回为字典形式
+ (NSDictionary *)readLocalFileWithName:(NSString *)name{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
