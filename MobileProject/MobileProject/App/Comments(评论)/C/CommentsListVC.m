//
//  CommentsListVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/11/5.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "CommentsListVC.h"
#import "UITableView+FMPlaceholder.h"
#import "CommentsCell.h"
@interface CommentsListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSMutableArray <FMMainModel *>*dataArr;

@end

@implementation CommentsListVC
- (NSMutableDictionary *)dic{
    if (_dic == nil) {
        _dic = [NSMutableDictionary dictionary];
        [_dic setObject:@"20" forKey:@"pageSize"];
    }
    return _dic;
}

- (NSMutableArray *)dataArr{
    if (_dataArr==nil) {
        _dataArr=[NSMutableArray array];
    }
    return _dataArr;
}

- (NSInteger)pageNum {
    
    if (_pageNum < 1) {
        _pageNum = 1;
    }
    
    return _pageNum;
}

- (NSInteger)pageSize {
    
    if (_pageSize < 1) {
        _pageSize = 20;
    }
    return _pageSize;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadtable];
    // Do any additional setup after loading the view.
}

- (void)loadtable{
    self.table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    self.table.delegate=self;
    self.table.dataSource=self;
    
    //设置可编辑
    //    self.table.allowsMultipleSelectionDuringEditing = YES;
    _table.tableFooterView = [UIView new];
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.mj_header=[XLHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    //    self.table.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    _table.needPlaceholderView = YES;
    __weak __typeof(self)weakSelf = self;
    _table.reloadBlock = ^{
        [weakSelf.table.mj_header beginRefreshing];
    };
    [self headerRefresh];
    
}

- (void)headerRefresh{
    self.pageNum=1;
    [self loadRefreshData];
}
- (void)footerRefresh{
    self.pageNum++;
    [self loadRefreshData];
}
- (void)loadRefreshData{
//    NSString *url = POSTTeamSchoolTeamSchoolList;
    [FMNetworkHelper fm_request_postWithUrlString:self.url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        NSArray *tpArray = responseObject[@"list"][@"rows"];
        if (self.pageNum==1) {
            [self.dataArr removeAllObjects];
        }
        if (tpArray) {
            for (NSDictionary *dic in tpArray) {
                FMMainModel *mode=[FMMainModel mj_objectWithKeyValues:dic];
                mode.deptId = self.deptId;
                [self.dataArr addObject:mode];
            }
        }
        [_table reloadData];
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        [_table.mj_footer endRefreshing];
        [_table.mj_header endRefreshing];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    //    POSTTeamSchoolList
}


#pragma mark-tableview代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
//        return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellID = [NSString stringWithFormat:@"CommentsCell"];
    CommentsCell *cell = [[CommentsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    if (!cell) {
//        cell = [[CommentsCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//    }
    cell.type = self.type;
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentsCell *cell = (CommentsCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return [cell getLayoutCellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
