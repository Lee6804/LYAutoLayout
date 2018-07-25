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

+(CGRect)getSize:(CGFloat)lessWidth str:(NSString *)str;

@end
