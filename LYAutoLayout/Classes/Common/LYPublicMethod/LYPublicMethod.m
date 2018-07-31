//
//  LYPublicMethod.m
//  LYAutoLayout
//
//  Created by Lee on 2018/7/30.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYPublicMethod.h"

@implementation LYPublicMethod

+(CGRect)getSize:(CGFloat)lessWidth str:(NSString *)str{
    CGRect labelSize = [str boundingRectWithSize:CGSizeMake(MainWidth - lessWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] context:nil];
    return labelSize;
}

@end
