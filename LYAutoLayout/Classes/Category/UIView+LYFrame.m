//
//  UIView+LYFrame.m
//  WWLR
//
//  Created by Lee on 2018/1/29.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "UIView+LYFrame.h"

@implementation UIView (LYFrame)

-(BOOL) containsSubView:(UIView *)subView
{
    for (UIView *view in [self subviews]) {
        if ([view isEqual:subView]) {
            return YES;
        }
    }
    return NO;
}


-(BOOL) containsSubViewOfClassType:(Class)aClass
{
    for (UIView *view in [self subviews]) {
        if ([view isMemberOfClass:aClass]) {
            return YES;
        }
    }
    return NO;
}

-(CGPoint) origin
{
    return self.frame.origin;
}

/**
 *  根据 Point 重新设置 Frame
 *
 *  @param newOrigin 新的 Point 点
 */
-(void) setOrigin:(CGPoint)newOrigin
{
    self.frame = CGRectMake(newOrigin.x, newOrigin.y, self.frame.size.width, self.frame.size.height);
}

-(CGSize) size
{
    return self.frame.size;
}

/**
 *  根据 Size 重新设置 Frame
 *
 *  @param newSize 新的 Size
 */

-(void) setSize:(CGSize)newSize
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newSize.width, newSize.height);
}

/**
 *  X
 */
-(CGFloat) originX
{
    return self.frame.origin.x;
}

-(void) setOriginX:(CGFloat)originX
{
    self.frame = CGRectMake(originX, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}


/**
 *  Y
 */

-(CGFloat)originY
{
    return self.frame.origin.y;
}

-(void)setOriginY:(CGFloat)originY
{
    self.frame = CGRectMake(self.frame.origin.x, originY, self.frame.size.width, self.frame.size.height);
}


/**
 *  右
 */

-(CGFloat)frameRight
{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setFrameRight:(CGFloat)newRight
{
    self.frame = CGRectMake(newRight - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

/**
 *  底
 */
-(CGFloat)frameBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setFrameBottom:(CGFloat)newBottom
{
    self.frame = CGRectMake(self.frame.origin.x, newBottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}

/**
 *  宽
 */
-(CGFloat)frameWidth
{
    return self.frame.size.width;
}

-(void)setFrameWidth:(CGFloat)newWidth
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newWidth, self.frame.size.height);
}

/**
 *  高
 */

-(CGFloat)frameHeight
{
    return self.frame.size.height;
}

-(void)setFrameHeight:(CGFloat)newHeight
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, newHeight);
}

/*
 *X中心
 */
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

/*
 *Y中心
 */
-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end
