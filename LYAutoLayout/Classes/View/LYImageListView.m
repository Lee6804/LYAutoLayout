//
//  LYImageListView.m
//  LYAutoLayout
//
//  Created by Lee on 2018/7/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYImageListView.h"

#define kImageWidth         75
// 图片间距
#define kImagePadding       5

// 内容视图宽度
#define kTextWidth          (MainWidth-60-25)

@interface LYImageListView()

@property(nonatomic,strong)NSMutableArray *imageViewArr;

@end

@implementation LYImageListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 小图(九宫格)
        _imageViewArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < 9; i++) {
            LYImageView *imageView = [[LYImageView alloc] initWithFrame:CGRectZero];
            imageView.tag = 1000 + i;
            [imageView setTapSmallView:^(LYImageView *imageView) {
                NSLog(@"%ld",imageView.tag);
            }];
            [_imageViewArr addObject:imageView];
            [self addSubview:imageView];
        }
    }
    return self;
}

#pragma mark - 获取整体高度
+ (CGFloat)imageListHeight:(LYModel *)model
{
    // 图片高度
    CGFloat height = 0;
    NSInteger count = [model.picurl isEqualToString:@""] ? 0 : [model.picurl componentsSeparatedByString:@"|"].count;
    if (count == 0) {
        height = 0;
    }  else if (count < 4) {
        height += kImageWidth;
    } else if (count < 7) {
        height += (kImageWidth*2 + kImagePadding);
    } else {
        height += (kImageWidth*3 + kImagePadding*2);
    }
    return height;
}

#pragma mark - Setter
- (void)setModel:(LYModel *)model
{
    _model = model;
    for (LYImageView *imageView in _imageViewArr) {
        imageView.hidden = YES;
    }
    // 图片区
    NSArray *imageAr = [model.picurl isEqualToString:@""] ? @[] : [model.picurl componentsSeparatedByString:@"|"];
    NSInteger count = imageAr.count;
    if (count == 0) {
        self.size = CGSizeZero;
        return;
    }
    // 更新视图数据
//    _previewView.pageNum = count;
//    _previewView.scrollView.contentSize = CGSizeMake(_previewView.width*count, _previewView.height);
    // 添加图片
    LYImageView *imageView = nil;
    for (NSInteger i = 0; i < count; i++)
    {
        if (i > 8) {
            break;
        }
        NSInteger rowNum = i/3;
        NSInteger colNum = i%3;
        if(count == 4) {
            rowNum = i/2;
            colNum = i%2;
        }
        
        CGFloat imageX = colNum * (kImageWidth + kImagePadding);
        CGFloat imageY = rowNum * (kImageWidth + kImagePadding);
        CGRect frame = CGRectMake(imageX, imageY, kImageWidth, kImageWidth);
        
        //单张图片需计算实际显示size
//        if (count == 1) {
//            CGSize singleSize = [LYImage getSingleSize:CGSizeMake(75, 75)];
//            frame = CGRectMake(0, 0, singleSize.width, singleSize.height);
//            frame = CGRectMake(0, 0, 75, 75);
//        }
        imageView = [self viewWithTag:1000+i];
        imageView.hidden = NO;
        imageView.frame = frame;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.easyyimin.com/%@",imageAr[i]]] placeholderImage:[UIImage imageNamed:@"photo"]];
    }
    self.frameWidth = kTextWidth;
    self.frameHeight = imageView.frameBottom;
}


@end

#pragma mark - ------------------ 单个小图显示视图 ------------------
@implementation LYImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clipsToBounds  = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.contentScaleFactor = [[UIScreen mainScreen] scale];
        self.userInteractionEnabled = YES;

        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestureCallback:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)singleTapGestureCallback:(UIGestureRecognizer *)gesture
{
    if (self.tapSmallView) {
        self.tapSmallView(self);
    }
}

@end
