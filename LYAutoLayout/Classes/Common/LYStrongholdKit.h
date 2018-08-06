//
//  LYStrongholdKit.h
//  LYAutoLayout
//
//  Created by Lee on 2018/7/30.
//  Copyright © 2018年 Lee. All rights reserved.
//


// 拼接宏
#define __LY_SPLICE_MACRO(pre,s) pre##s
#define _LY_SPLICE_MACRO(pre,s) __LY_SPLICE_MACRO(pre,s)

// 打印自定义宏名
#define __LY_CUSTOME_MACRO_STR(s) #s
#define _LY_CUSTOME_MACRO_STR(s) __LY_CUSTOME_MACRO_STR(s)
#define LY_CUSTOME_MACRO_STR(s) [NSString stringWithUTF8String:_LY_CUSTOME_MACRO_STR(s)]

#pragma mark - 方法
// 自定义方法前缀
#define LY_METHOD_PREFIX LY_AutoLayout_
// 全局自定义的方法，都用这个宏进行包装
#define LY_CUSTOME_METHOD(s) _LY_SPLICE_MACRO(LY_METHOD_PREFIX,s)
// 自定义方法名字符串
#define LY_CUSTOME_METHOD_STR(s) [NSString stringWithUTF8String:_LY_CUSTOME_MACRO_STR(LY_CUSTOME_METHOD(s))]

#pragma mark - 类
// 自定义类前缀
#define LY_CLASS_PREFIX LY_AutoLayout_
// 全局自定义的类，都用这个宏进行包装。
// 需要注意的是，如果使用SB/xib新建对象，则不要使用这个宏
#define LY_CUSTOME_CLASS(s) _LY_SPLICE_MACRO(LY_CLASS_PREFIX,s)
// 自定义类名字符串
#define LY_CUSTOME_CLASS_STR(s) [NSString stringWithUTF8String:_LY_CUSTOME_MACRO_STR(LY_CUSTOME_CLASS(s))]

#pragma mark - 代理
// 自定义代理前缀
#define LY_PROTOCOL_PREFIX LY_AutoLayout_
// 全局自定义的代理，都用这个宏进行包装。
#define LY_CUSTOME_PROTOCOL(s) _LY_SPLICE_MACRO(_LY_SPLICE_MACRO(LY_PROTOCOL_PREFIX,s),Delegate)
// 自定义代理名字符串
#define LY_CUSTOME_PROTOCOL_STR(s) [NSString stringWithUTF8String:_LY_CUSTOME_MACRO_STR(LY_CUSTOME_PROTOCOL(s))]

#pragma mark - 属性
// 自定义变量/属性名
#define LY_VAR_PREFIX JMHvar_
// 全局属性名
#define LY_CUSTOME_VAR(s) _LY_SPLICE_MACRO(LY_VAR_PREFIX,s)
// 全局实例名
#define LY_CUSTOME_INS(s) _LY_SPLICE_MACRO(_, _LY_SPLICE_MACRO(LY_VAR_PREFIX,s))
// 属性名的getter
#define LY_CUSTOME_VAR_GETTER(s) LY_CUSTOME_VAR(s)
// 属性名的setter
#define LY_CUSTOME_VAR_SETTER(s) _LY_SPLICE_MACRO(set,LY_CUSTOME_VAR(s))


#import <AFNetworking.h>
#import <UITableView+FDTemplateLayoutCell.h>
#import <Masonry.h>
#import <MJExtension.h>
#import <UIImageView+WebCache.h>
#import <WHDebugTool/WHDebugToolManager.h>

#import "NSDictionary+Log.h"
#import "UIView+LYFrame.h"

#import "LYPublicMethod.h"
#import "LYImage.h"
