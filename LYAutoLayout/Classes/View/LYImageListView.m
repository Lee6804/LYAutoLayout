//
//  LYImageListView.m
//  LYAutoLayout
//
//  Created by Lee on 2018/7/31.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYImageListView.h"
#import "LYImagePreviewView.h"

#define kImageWidth         75
// 图片间距
#define kImagePadding       5

// 内容视图宽度
#define kTextWidth          (MainWidth-60-25)

@interface LYImageListView()<UIAlertViewDelegate>

@property(nonatomic,strong)NSMutableArray *imageViewArr;

// 预览视图
@property (nonatomic, strong) LYImagePreviewView *previewView;

@property (nonatomic,assign)BOOL isShowBig;

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
                [self singleTapSmallViewCallback:imageView];
            }];
            [_imageViewArr addObject:imageView];
            [self addSubview:imageView];
        }
        // 预览视图
        _previewView = [[LYImagePreviewView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
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
    _previewView.pageNum = count;
    _previewView.scrollView.contentSize = CGSizeMake(_previewView.frameWidth*count, _previewView.frameHeight);
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


#pragma mark - 小图单击
- (void)singleTapSmallViewCallback:(LYImageView *)imageView
{
    if (self.isShowBig == NO) {
        self.isShowBig = YES;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        // 解除隐藏
        [window addSubview:_previewView];
        [window bringSubviewToFront:_previewView];
        
        // 清空
        [_previewView.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        for (UIView *view in _previewView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [_previewView removeGestureRecognizer:(UITapGestureRecognizer *)view];
            }
        }
        
        // 添加子视图
        NSInteger index = imageView.tag-1000;
        NSArray *imageArr = [_model.picurl componentsSeparatedByString:@"|"];
        NSInteger count = imageArr.count;
        CGRect convertRect;
        if (count == 1) {
            [_previewView.pageControl removeFromSuperview];
        }
        for (NSInteger i = 0; i < count; i ++)
        {
            // 转换Frame
            LYImageView *pImageView = (LYImageView *)[self viewWithTag:1000+i];
            convertRect = [[pImageView superview] convertRect:pImageView.frame toView:window];
            // 添加
            LYScrollView *scrollView = [[LYScrollView alloc] initWithFrame:CGRectMake(i*_previewView.frameWidth, 0, _previewView.frameWidth, _previewView.frameHeight)];
            scrollView.tag = 100+i;
            scrollView.maximumZoomScale = 2.0;
            //        scrollView.image = pImageView.image;
            scrollView.imageUrl = imageArr[i];
            scrollView.contentRect = convertRect;
            // 单击
            [scrollView setTapBigView:^(LYScrollView *scrollView){
                [self singleTapBigViewCallback:scrollView];
            }];
            // 长按
            [scrollView setLongPressBigView:^(LYScrollView *scrollView){
                [self longPresssBigViewCallback:scrollView];
            }];
            [_previewView.scrollView addSubview:scrollView];
            if (i == index) {
                [UIView animateWithDuration:0.3 animations:^{
                    self->_previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
                    self->_previewView.pageControl.hidden = NO;
                    [scrollView updateOriginRect];
                }];
            } else {
                [scrollView updateOriginRect];
            }
        }
        // 更新offset
        CGPoint offset = _previewView.scrollView.contentOffset;
        offset.x = index * MainWidth;
        _previewView.pageIndex = index;
        _previewView.scrollView.contentOffset = offset;
        
    }
}

#pragma mark - 大图单击||长按
- (void)singleTapBigViewCallback:(LYScrollView *)scrollView
{
    [UIView animateWithDuration:0.3 animations:^{
        self->_previewView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self->_previewView.pageControl.hidden = YES;
        scrollView.contentRect = scrollView.contentRect;
        scrollView.zoomScale = 1.0;
    } completion:^(BOOL finished) {
        [self->_previewView removeFromSuperview];
        self.isShowBig = NO;
    }];
}

- (void)longPresssBigViewCallback:(LYScrollView *)scrollView{
    [[[UIAlertView alloc] initWithTitle:@"提示" message:@"保存到相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil] show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",buttonIndex);
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
