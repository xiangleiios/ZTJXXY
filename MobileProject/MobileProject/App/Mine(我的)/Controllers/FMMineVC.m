//
//  FMMineVC.m
//  MobileProject
//
//  Created by Mingo on 2017/7/31.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMMineVC.h"
#import "XLInformationV.h"
#import "AboutUs.h"
#import "MyInfoVC.h"
#import "XLMineCell.h"
#import "FMClearCacheTool.h"
#import "SelectRoleVC.h"
#import "SchoolRankingListVC.h"
#import "InvitationCoachVC.h"
#import "RankingDetailsVC.h"
#import "AllWeb.h"
#import "BusinessCardVC.h"
#import "BranchSchoolListVC.h"

#import "MyCourse.h"

#import "MyNewsVC.h"
#define HEADERHEI KFit_H6S(320)

@interface FMMineVC ()<UIImagePickerControllerDelegate>

@property (nonatomic , strong)UITableView *table;
@property (nonatomic , strong)NSArray *imgarr;
@property (nonatomic , strong)NSArray *titlerr;
@property (nonatomic , strong)NSString *cacheSize;

@property (nonatomic , strong)UILabel *pho;
@property (nonatomic , strong)UILabel *school;
@property (nonatomic , strong)FMMainModel *coachModel;

@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic , strong)MyCourse *myCourse;
@property (nonatomic , strong)XLView *backView;
@property (nonatomic , strong)XLView *Butview;

@end

@implementation FMMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titlerr = @[@"  我的咨询",@"  我的订单",@"  预约练车",@"  消息中心",@"  意见反馈",@"  关于我们"];
    self.imgarr = @[@"myseek",@"orde",@"make",@"news",@"idea",@"about"];
        
    
    [self laodNavigation];
    
    
    [self loadScrollview];
    
    [self loadMineView];
    
    [self loadMyCourse];
    
    [self loadFunctionBut];
    
//    [self laodSubview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setNavigationBackgroundImage:[UIImage imageWithColor:kColor_N(63, 129, 247)]];
    self.navigationView.lineView.hidden = YES;
//    [self.navigationView setNavigationBackgroundColor:kColor_N(63, 129, 247)];
}


- (void)loadScrollview{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    /// 顶部对齐问题
    self.scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.backView = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backView];
    [self.navigationView navigationAlphaSlowChangeWithScrollow:self.scroll];
}

- (void)loadMineView{
    UIImageView *img = [[UIImageView alloc] init];
    [self.backView addSubview:img];
    [img setImage:[UIImage imageNamed:@"my_bg"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.backView);
        make.height.mas_equalTo(KFit_H6S(464));
    }];
    
    UILabel *lb = [[UILabel alloc] init];
    lb.backgroundColor = [UIColor whiteColor];
    [self.backView addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView).mas_offset(KFit_H6S(150));
        make.left.mas_equalTo(self.backView).mas_offset(KFit_W6S(30));
        make.width.height.mas_equalTo(KFit_W6S(120));
    }];
    lb.layer.cornerRadius = KFit_W6S(60);
    lb.layer.masksToBounds = YES;
    
    
    self.HeadPortrait = [[UIImageView alloc] init];
    [self.backView addSubview:self.HeadPortrait];
    [self.HeadPortrait mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(lb);
        make.width.height.mas_equalTo(KFit_W6S(100));
    }];
    self.HeadPortrait.userInteractionEnabled = YES;
    self.HeadPortrait.layer.cornerRadius = KFit_W6S(50);
    self.HeadPortrait.layer.masksToBounds = YES;
    self.HeadPortrait.contentMode = UIViewContentModeScaleAspectFill;
    [self.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:KURLIma([User UserOb].teamUserHead)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
    KKLog(@"%@",KURLIma([User UserOb].teamUserHead));
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeUp)];
    // 允许用户交互
    [self.HeadPortrait addGestureRecognizer:tap];
    
    self.pho = [[UILabel alloc] init];
    [self.backView addSubview:self.pho];
    self.pho.textColor = [UIColor whiteColor];
    self.pho.text = @"向蕾";
    self.pho.font = [UIFont systemFontOfSize:kFit_Font6(19) weight:0.5];
    [self.pho mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.HeadPortrait).mas_offset(-KFit_H6S(30));
        make.left.mas_equalTo(self.HeadPortrait.mas_right).mas_offset(KFit_W6S(30));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
    UIButton *but = [[UIButton alloc] init];
    [self.backView addSubview:but];
    [but addTarget:self action:@selector(toMingpan) forControlEvents:UIControlEventTouchUpInside];
    [but setTitle:@"查看和编辑资料 ▸" forState:UIControlStateNormal];
    but.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    but.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.HeadPortrait).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(self.HeadPortrait.mas_right).mas_offset(KFit_W6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(460), KFit_H6S(40)));
        
    }];
    
    UIImageView *imgtwo = [[UIImageView alloc] init];
    [self.backView addSubview:imgtwo];
    [imgtwo setImage:[UIImage imageNamed:@"my_bg_white"]];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.HeadPortrait.mas_bottom).mas_offset(KFit_H6S(35));
        make.left.right.mas_equalTo(self.backView);
        make.height.mas_equalTo(KFit_H6S(260));
    }];
    
    
    XLxqbut *butone = [[XLxqbut alloc] init];
    [butone addTarget:self action:@selector(toZhaosheng) forControlEvents:UIControlEventTouchUpInside];
    [butone setImage:[UIImage imageNamed:@"promotion"] forState:UIControlStateNormal];
    [butone setTitle:@"优惠券" forState:UIControlStateNormal];
    [butone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butone.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.3];
    
    XLxqbut *buttwo = [[XLxqbut alloc] init];
    [buttwo addTarget:self action:@selector(toMingpan) forControlEvents:UIControlEventTouchUpInside];
    [buttwo setImage:[UIImage imageNamed:@"invite"] forState:UIControlStateNormal];
    [buttwo setTitle:@"邀请返利" forState:UIControlStateNormal];
    [buttwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttwo.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.2];
    
    XLxqbut *butthree = [[XLxqbut alloc] init];
    [butthree addTarget:self action:@selector(toAddStudent) forControlEvents:UIControlEventTouchUpInside];
    [butthree setImage:[UIImage imageNamed:@"purse"] forState:UIControlStateNormal];
    [butthree setTitle:@"我的钱包" forState:UIControlStateNormal];
    [butthree setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    butthree.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.2];
    
    
    [imgtwo addSubview:butone];
    [imgtwo addSubview:buttwo];
    [imgtwo addSubview:butthree];
    
    NSArray *toolarr = @[butone,buttwo,butthree];
    [toolarr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(140) leadSpacing:KFit_W6S(90) tailSpacing:KFit_W6S(90)];
    [toolarr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imgtwo).mas_offset(-KFit_H6S(20));
        make.height.mas_equalTo(KFit_W6S(150));
    }];
    
}


- (void)toMingpan{
    MyInfoVC *vc = [[MyInfoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}













- (void)loadMyCourse{
    MyCourse *v = [[MyCourse alloc] init];
    self.myCourse = v;
    [self.backView addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backView);
        make.top.mas_equalTo(self.backView).mas_offset(KFit_H6S(550));
        make.height.mas_equalTo(KFit_H6S(300));
    }];
}

- (void)loadFunctionBut{
    self.Butview = [[XLView alloc] init];
    [self.backView addSubview:self.Butview];
    float w = KFit_W6S(250);
    float h = KFit_W6S(80);
    for (int i = 0; i < self.titlerr.count; i++) {
        UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(i%2*(SCREEN_WIDTH - KFit_W6S(60))/2.0, KFit_H6S(120)*(i/2), w, h)];
        [self.Butview addSubview:but];
        [but setTitle:self.titlerr[i] forState:UIControlStateNormal];
        [but setImage:[UIImage imageNamed:self.imgarr[i]] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(functionBut:) forControlEvents:UIControlEventTouchUpInside];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.tag = i;
    }
    if (self.myCourse) {
        [self.Butview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backView).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self.backView).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(self.myCourse.mas_bottom).mas_offset(KFit_H6S(50));
            make.height.mas_equalTo([self.Butview getLayoutCellHeight]);
        }];
    }else{
        [self.Butview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.backView).mas_offset(KFit_W6S(30));
            make.right.mas_equalTo(self.backView).mas_offset(-KFit_W6S(30));
            make.top.mas_equalTo(self.backView).mas_offset(KFit_H6S(550));
            make.height.mas_equalTo([self.Butview getLayoutCellHeight]);
        }];
    }
}


- (void)functionBut:(UIButton *)senter{
    switch (senter.tag) {
            case 0:
            
            break;
            case 1:
            
            break;
            case 2:
            
            break;
            case 3:{
                MyNewsVC *vc = [[MyNewsVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            break;
            case 4:
            
            break;
            case 5:{
                AboutUs *vc = [[AboutUs alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
            break;
            
            
        default:
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [self.table.mj_header beginRefreshing];
}



- (void)viewDidLayoutSubviews{
    self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backView getLayoutCellHeightWithFlex:KFit_H6S(30)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backView.frame));
}












- (void)cleanUpcache{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否清除缓存" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {}]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [FMRegExpTool clearFile];
        if ([FMClearCacheTool fm_clearCacheWithFilePath:kCachePath]) {
            [MBProgressHUD showAutoMessage:@"已清除缓存"];
        }
        [self.table reloadData];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)theLoginStatusChange{
    
}



- (void)logOut:(UIButton *)sender{
    XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"是否退出登录" sureBtn:@"确定" cancleBtn:@"取消"];
    [alert showXLAlertView];
    alert.resultIndex = ^(NSInteger index) {
        KKLog(@"%ld",(long)index);
        if (index == 2) {
//            [[User UserOb] UserQuit];
            LoginVC *vc = [[LoginVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    
    
}





- (void)changeUp{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"请选择添加途径" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //默认只有标题 没有操作的按钮:添加操作的按钮 UIAlertAction
    
    UIAlertAction *cancelBtn = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        //        NSLog(@"取消");
        [self PhotoLibrary];
    }];
    
    UIAlertAction *cancelBtXJ = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self xiangji];
        NSLog(@"取消");
        
    }];
    //添加确定
    UIAlertAction *sureBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"确定");
        
    }];
    //设置`确定`按钮的颜色
    //    [sureBtn setValue:[UIColor redColor] forKey:@"titleTextColor"];
    //将action添加到控制器
    [alertVc addAction:cancelBtn];
    [alertVc addAction:cancelBtXJ];
    [alertVc addAction :sureBtn];
    //展示
    [self presentViewController:alertVc animated:YES completion:nil];
    
    
}


///
- (void)xiangji{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertView * alerr = [[UIAlertView alloc]initWithTitle:@"警告!" message:@"未找到该硬件设备或设备已损坏" delegate:self cancelButtonTitle:nil otherButtonTitles:@"我知道了", nil];
        [alerr show];
    }else{
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.allowsEditing = YES;
        
    }
    //利用模态进行调用系统框架
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
    
}
//照片库
- (void)PhotoLibrary{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.mediaTypes = [NSArray arrayWithObject:(__bridge NSString *)kUTTypeImage];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.allowsEditing = YES;
    
    [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];;
}

#pragma mark -相册代理
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    KKLog(@"%@    ----- %@",picker,info);
    //UIImagePickerControllerEditedImage   UIImagePickerControllerOriginalImage
    [self uploadPictures:info[UIImagePickerControllerEditedImage]];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


- (void)uploadPictures:(UIImage *)image{
    [MBProgressHUD showLoadingHUD:@"正在上传图片"];
    
    
    NSString *url = POSTUpLoadFile;
    
    
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [manager.requestSerializer setValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.1) name:@"file" fileName:@"tupian.png" mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"成功返货=============%@",responseObject);
        [MBProgressHUD hideLoadingHUD];
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSDictionary *dic =responseObject[@"data"][@"data"];
//            [self.imgarr addObject:dic[@"url"]];
            [self chengHeader:dic[@"url"]];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideLoadingHUD];
    }];
}




- (void)chengHeader:(NSString *)img{
    NSString *url;
    NSDictionary *dic;
    if (USERFZR) {
        url = [NSString stringWithFormat:POSTUpdateTeamUserHeadImg,img];
    }else{
        url = POSTUpdateCoach;
        dic = @{@"headPic":img};
    }
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:dic successBlock:^(id responseObject) {
        KKLog(@"%@",responseObject);
        if (kResponseObjectStatusCodeIsEqual(200)) {
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:KURLIma(img) forKey:@"teamUserHead"];
            [defaults synchronize];
            [User UserOb].teamUserHead = KURLIma(img);
            [self.HeadPortrait sd_setImageWithURL:[NSURL URLWithString:KURLIma(img)] placeholderImage:[UIImage imageNamed:@"touxiang_nor"]];
            
        }
        
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}


@end
