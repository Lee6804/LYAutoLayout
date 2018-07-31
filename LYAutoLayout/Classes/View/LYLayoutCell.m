//
//  LYLayoutCell.m
//  LYAutoLayout
//
//  Created by Lee on 2018/7/23.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "LYLayoutCell.h"
#import "LYImageListView.h"

#define SWidth [UIScreen mainScreen].bounds.size.width
#define SHeight [UIScreen mainScreen].bounds.size.height

#define TColor [UIColor colorWithRed:100/255.0 green:105/255.0 blue:150/255.0 alpha:1]

#define Space 10

@interface LYLayoutCell()

@property(nonatomic,strong)UIImageView *headImg;
@property(nonatomic,strong)UILabel *nickNameLabel;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UIButton *moreBtn;
@property(nonatomic,strong)LYImageListView *imageListView;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *addressLabel;
@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,assign)BOOL isShowAll;

@end

@implementation LYLayoutCell


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.headImg = [UIImageView new];
    [self.contentView addSubview:self.headImg];
    
    self.nickNameLabel = [UILabel new];
    self.nickNameLabel.textColor = TColor;
    self.nickNameLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.nickNameLabel];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.textColor = [UIColor lightGrayColor];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    self.moreBtn = [UIButton new];
    [self.moreBtn setTitle:@"全文" forState:UIControlStateNormal];
    [self.moreBtn setTitle:@"收起" forState:UIControlStateSelected];
    [self.moreBtn setTitleColor:TColor forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.moreBtn.hidden = YES;
    [self.contentView addSubview:self.moreBtn];
    
    // 图片区
    self.imageListView = [LYImageListView new];
    [self.contentView addSubview:self.imageListView];

    self.timeLabel = [UILabel new];
    self.timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.timeLabel];
    
    self.addressLabel = [UILabel new];
    self.addressLabel.textColor = TColor;
    self.addressLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.addressLabel];
    
    self.lineView = [UIView new];
    self.lineView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [self.contentView addSubview:self.lineView];
    
    [self.headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(Space);
        make.left.equalTo(self.contentView.mas_left).offset(Space);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImg.mas_top);
        make.left.equalTo(self.headImg.mas_right).offset(Space);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameLabel.mas_bottom).offset(Space);
        make.left.equalTo(self.headImg.mas_right).offset(Space);
        make.right.equalTo(self.contentView.mas_right).offset(-Space);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImg.mas_bottom).offset(10);
        make.left.mas_equalTo(self.titleLabel.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-Space);
        make.height.mas_equalTo(0);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentLabel.mas_bottom).offset(Space/2);
        make.left.mas_equalTo(self.contentLabel.mas_left);
        make.height.mas_equalTo(0);
    }];
    
    [self.imageListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.moreBtn.mas_bottom).offset(Space/2);
        make.left.mas_equalTo(self.contentLabel.mas_left);
        make.right.mas_equalTo(self.contentLabel.mas_right);
//        make.height.mas_equalTo(0);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageListView.mas_bottom).offset(Space/2);
        make.left.mas_equalTo(self.contentLabel.mas_left);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentLabel.mas_right).offset(-Space);
        make.centerY.mas_equalTo(self.timeLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-Space);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(SWidth);
        make.height.mas_equalTo(1);
    }];
}


-(void)setModel:(LYModel *)model{
    
    _model = model;
    
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:model.portrait] placeholderImage:[UIImage imageNamed:@"photo"]];
    self.nickNameLabel.text = model.nickname;
    self.titleLabel.text = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:model.title options:0] encoding:NSUTF8StringEncoding];
    NSString *contentStr = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:model.content options:0] encoding:NSUTF8StringEncoding];
    self.contentLabel.text = contentStr;
    self.moreBtn.hidden = [self getSize:80 str:contentStr].size.height > 100 ? NO : YES;
    self.moreBtn.selected = self.model.unfold;

    [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(model.unfold ? [self getSize:80 str:contentStr].size.height : (self.moreBtn.hidden == YES ? [self getSize:80 str:contentStr].size.height + 1 : 100));
    }];
    
    
    [self.moreBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.moreBtn.hidden == YES ? 0 : 20);
    }];
    
    self.imageListView.model = model;
    
    self.timeLabel.text = model.time;
    self.addressLabel.text = [model.address isEqualToString:@""] ? @"" : model.address;
}

-(void)moreBtnClick{
    self.model.unfold = !self.model.unfold;
    !_reloadTabBlock ? : _reloadTabBlock();
}

-(void)setCornerRadius:(UIImageView *)imageView{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.bounds.size];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
}

- (CGRect)getSize:(CGFloat)lessWidth str:(NSString *)str{
    CGRect labelSize = [str boundingRectWithSize:CGSizeMake(SWidth-lessWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName, nil] context:nil];
    return labelSize;
}

+(CGFloat)cellTotalHeight:(LYModel *)model{
    NSString *contentStr = [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:model.content options:0] encoding:NSUTF8StringEncoding];
    CGFloat height = 70;//内容以上的固定高度 headImg高度+2个Space
    if (model.unfold) {
        height += [LYPublicMethod getSize:80 str:contentStr].size.height;//展开状态下 累加内容label高度
        height += 56;//下面多余控件总高度
    }else{
        if ([LYPublicMethod getSize:80 str:contentStr].size.height > 100) {
            height += 120;
        }else{
            height += [LYPublicMethod getSize:80 str:contentStr].size.height;
        }
        height += 40;
    }
    
    NSInteger count = [model.picurl componentsSeparatedByString:@"|"].count;
    if (count != 0) {
        height += [LYImageListView imageListHeight:model];
    }
    
    if (![model.picurl isEqualToString:@""]) {
        height += 10;
    }
    
    return height;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
