//
//  LYModel.m
//  LYAutoLayout
//
//  Created by Lee on 2018/7/23.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYModel.h"
#import <MJExtension.h>

@implementation LYModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"userId":@"id"};
}

@end
