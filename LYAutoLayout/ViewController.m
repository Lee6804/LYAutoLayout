//
//  ViewController.m
//  LYAutoLayout
//
//  Created by Lee on 2018/7/23.
//  Copyright © 2018年 Lee. All rights reserved.
//

#import "ViewController.h"

#import "LYModel.h"
#import "LYLayoutCell.h"

static NSString *const LYCELL = @"LYCell";

#define SWidth self.view.frame.size.width
#define SHeight self.view.frame.size.height

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation ViewController

-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}

-(void)loadHttpData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",@"multipart/form-data",nil];
    [manager POST:@"http://m.easyyimin.com/index.php/Home/Interface/showmessage" parameters:@{@"username":@"151123886804",@"page":@(4)} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (NSDictionary *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

-(void)loadData{

    self.data = [LYModel mj_objectArrayWithKeyValuesArray:[self readLocalFileWithName:@"responseObject"][@"data"]];
    [self.tableView reloadData];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SWidth, SHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] init];
//        _tableView.estimatedRowHeight = 20;
        [_tableView registerClass:[LYLayoutCell class] forCellReuseIdentifier:LYCELL];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[WHDebugToolManager sharedInstance] toggleWith:DebugToolTypeFPS | DebugToolTypeMemory | DebugToolTypeCPU];
    self.navigationItem.title = @"自动布局";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:self.tableView];
    [self loadData];
    [self loadHttpData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = [LYLayoutCell cellTotalHeight:[self.data objectAtIndex:indexPath.row]];
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LYLayoutCell *cell = (LYLayoutCell *)[tableView dequeueReusableCellWithIdentifier:LYCELL];
    cell.model = self.data[indexPath.row];    
    __weak typeof(self)weakSelf = self;
    cell.reloadTabBlock = ^{
        [weakSelf.tableView reloadData];
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
