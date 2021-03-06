//
//  LoginVC.m
//  MobileProject
//
//  Created by zsgy on 17/8/1.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "LoginVC.h"
#import "XLPartyLoginV.h"
#import "ForgotPasswordVC.h"
#import "UIWebView+FMSetTonkenToCookie.h"
#import "XLCache.h"
#import "CYLTabBarControllerConfig.h"
#import "JPUSHService.h"
#import "SelectSchoolVC.h"

#import "ChangePasswordVC.h"
@interface LoginVC ()<UITextFieldDelegate>
@property (nonatomic , strong)TKPhoneTextField *pho;
@property (nonatomic , strong)UITextField *password;
@property (nonatomic , strong)UIImageView *logimg;
@property (nonatomic , strong)UIButton *veribut;

@property (nonatomic , strong)UIButton *logYZM;
@property (nonatomic , strong)UIButton *logMM;
@property (nonatomic , strong)UIButton *selectBut;

@property (nonatomic , strong)UIButton *forgotPassword;
@property (nonatomic , strong)UIButton *loginBut;

@property (nonatomic , strong)UILabel *selectLB;

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationView setTitle:@""];
    self.view.backgroundColor=[UIColor whiteColor];

    
    /*图标*/
    [self loadingIcon];
    ///
    [self loadLogBut];
    /* 账号密码*/
    [self loadTheLoginBox];
    /* 登录注册按钮*/
    [self loadTheFunctionButton];
    
    
    
    /*目前没有第三方登录 */
//    [self DSFlogin];
    // Do any additional setup after loading the view.
}





- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController fm_setStatusBarBackgroundColor:[UIColor clearColor]];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

}

- (void)loadingIcon{
    UIImageView *img=[[UIImageView alloc]init];
    self.logimg=img;
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).mas_offset(KFit_H6S(130));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(75));
        make.size.mas_equalTo(CGSizeMake(KFit_H6S(502), KFit_H6S(160)));
    }];
    [img setImage:[UIImage imageNamed:@"head"]];
}

- (void)loadLogBut{
    self.logYZM = [[UIButton alloc] init];
    self.logYZM.frame = CGRectMake(KFit_W6S(75), KFit_H6S(340), KFit_W6S(200), KFit_H6S(50));
    [self.view addSubview:_logYZM];
    [_logYZM setTitle:@"验证码登录" forState:UIControlStateNormal];
    _logYZM.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _logYZM.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.5];
    _logYZM.selected = YES;
    self.selectBut = _logYZM;
    _logYZM.tag = 1;
    [_logYZM setTitleColor:kColor_N(71, 85, 115) forState:UIControlStateNormal];
    [_logYZM setTitleColor:kColor_N(0, 105, 234) forState:UIControlStateSelected];
    [_logYZM addTarget:self action:@selector(logType:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.logMM = [[UIButton alloc] init];
    self.logMM.frame = CGRectMake(KFit_W6S(315), KFit_H6S(340), KFit_W6S(200), KFit_H6S(50));
    [self.view addSubview:_logMM];
    _logMM.tag = 2;
    [_logMM setTitle:@"密码登录" forState:UIControlStateNormal];
    _logMM.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _logMM.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.5];
    [_logMM addTarget:self action:@selector(logType:) forControlEvents:UIControlEventTouchUpInside];
    [_logMM setTitleColor:kColor_N(71, 85, 115) forState:UIControlStateNormal];
    [_logMM setTitleColor:kColor_N(0, 105, 234) forState:UIControlStateSelected];
    
    
    
    self.selectLB = [[UILabel alloc] init];
    self.selectLB.frame = CGRectMake(CGRectGetMinX(_logYZM.frame), KFit_H6S(410), KFit_W6S(50), KFit_H6S(4));
    [self.view addSubview:self.selectLB];
    self.selectLB.backgroundColor = kColor_N(0, 105, 234);
    
    
}

- (void)logType:(UIButton *)senter{
    self.selectBut.selected = NO;
    senter.selected = YES;
    self.selectBut = senter;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.selectLB.frame = CGRectMake(CGRectGetMinX(senter.frame), KFit_H6S(410), KFit_W6S(50), KFit_H6S(4));
    }];
    
    [self changLoninType];
}

#pragma mark -改变登录类型
- (void)changLoninType{
    
    if (self.selectBut.tag == 1) {
        self.password.placeholder=@"请输入验证码";
        self.veribut.hidden = NO;
        [self.loginBut setTitle:@"登录/注册" forState:UIControlStateNormal];
        self.forgotPassword.hidden = YES;
    }else{
        self.password.placeholder=@"请输入密码";
        self.veribut.hidden = YES;
        [self.loginBut setTitle:@"登录" forState:UIControlStateNormal];
        self.forgotPassword.hidden = NO;
    }
    
}


- (void)loadTheLoginBox{
    UIView *v=[[UIView alloc]init];
    [self.view addSubview:v];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logimg.mas_bottom).mas_offset(KFit_H6S(150));
        make.left.mas_equalTo(self.view).mas_offset(KFit_W6S(75));
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(75));
        make.height.mas_equalTo(KFit_H6S(220));
    }];
    self.pho=[[TKPhoneTextField alloc]initWithFrame:CGRectMake(0, 0, KFit_W6S(550), KFit_H6S(110))];
    self.pho.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.pho];
    self.pho.placeholder=@"请输入账号";
    self.pho.keyboardType=UIKeyboardTypeNumberPad;
    self.pho.delegate =self;
    
//    UIImageView *imgpass=[[UIImageView alloc]initWithFrame:CGRectMake(0, KFit_H6S(140), KFit_W6S(32), KFit_H6S(45))];
//    [imgpass setImage:[UIImage imageNamed:@"password"]];
//    [v addSubview:imgpass];
    self.password=[[UITextField alloc]initWithFrame:CGRectMake(0, KFit_H6S(110), KFit_W6S(550), KFit_H6S(110))];
    self.password.font=[UIFont systemFontOfSize:kFit_Font6(15)];
    [v addSubview:self.password];
    self.password.placeholder=@"请输入验证码";
    self.password.secureTextEntry=YES;
    
    
    
    self.veribut=[[UIButton alloc]init];
    [v addSubview:self.veribut];
    [self.veribut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(v).mas_offset(-KFit_W6S(15));
        make.centerY.mas_equalTo(self.password);
        make.width.mas_equalTo(KFit_W6S(150));
        make.height.mas_equalTo(KFit_H6S(54));
    }];
    [self.veribut setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.veribut setTitleColor:kColor_N(0, 105, 234) forState:UIControlStateNormal];
    [self.veribut addTarget:self action:@selector(getVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    self.veribut.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(12)];
    self.veribut.layer.cornerRadius = KFit_H6S(27);
    self.veribut.layer.borderColor = kColor_N(0, 105, 234).CGColor;
    self.veribut.layer.borderWidth = 0.5;
    //15658458745   18810395609  13154898589  15512341234  15007125433  17764076879 13100704044 13100704044
#ifdef DEBUG
    self.pho.text = @"13100704044";
    self.password.text = @"123456";
#else
    
#endif
    NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
    self.pho.text = [defaults objectForKey:@"Loginaccount"];
    
    UILabel *lb=[[UILabel alloc]init];
    lb.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lb];
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerY.centerX.mas_equalTo(v);
        make.height.mas_equalTo(1);
    }];
    
    UILabel *lbt=[[UILabel alloc]init];
    lbt.backgroundColor=kRGBColor(239, 239, 246);
    [v addSubview:lbt];
    [lbt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.bottom.mas_equalTo(v);
        make.height.mas_equalTo(1);
    }];
    
}

- (void)getVerificationCode{
    NSString *p = [self.pho.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phone = [p stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if( phone.length < 1 )
    {
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }
    if( ![FMRegExpTool fm_checkingMobile:phone] )
    {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    }
    
    
    NSString *url=[NSString stringWithFormat:GETmembersMobileCheckcode,phone,0];
    [FMNetworkHelper fm_request_getWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(200)) {
            [MBProgressHUD showAutoMessage:@"已发送"];
            [FMRegExpTool startTime:self.veribut];
        }else{
            [MBProgressHUD showAutoMessage:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {

    } progress:nil];
}




- (void)loadTheFunctionButton{

    self.forgotPassword = [[UIButton alloc] init];
    [self.view addSubview:self.forgotPassword];
    self.forgotPassword.hidden = YES;
    [self.forgotPassword setTitle:@"忘记密码" forState:UIControlStateNormal];
    [self.forgotPassword addTarget:self action:@selector(toForgotPassword) forControlEvents:UIControlEventTouchUpInside];
    self.forgotPassword.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(12)];
    [self.forgotPassword setTitleColor:kColor_N(0, 105, 234) forState:UIControlStateNormal];
    [self.forgotPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).mas_offset(-KFit_W6S(75));
        make.top.mas_equalTo(self.password.mas_bottom).mas_offset(KFit_H6S(10));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(120), KFit_H6S(50)));
    }];
    
    
    
    
    UIButton *login=[[UIButton alloc]init];
    self.loginBut = login;
    [self.view addSubview:login];
    login.backgroundColor=kRGBColor(0, 112, 234 );
    [login setTitle:@"登录/注册" forState:UIControlStateNormal];
    login.titleLabel.font=[UIFont systemFontOfSize:kFit_Font6(18)];
    [login addTarget:self action:@selector(loging) forControlEvents:UIControlEventTouchUpInside];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.password.mas_bottom).mas_offset(KFit_H6S(70));
         make.height.mas_equalTo(KFit_H6S(90));
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(KFit_W6S(640));
    }];
    login.layer.cornerRadius = KFit_H6S(45);
    
}
#pragma mark - 忘记密码
- (void)toForgotPassword{
//    ForgotPasswordVC *vc = [[ForgotPasswordVC alloc] init];
    ChangePasswordVC *vc = [[ChangePasswordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 登录方法
- (void)loging{
    [self.view endEditing:YES];
    NSString *p = [self.pho.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString* phone = [p stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString* password=[self.password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if( phone.length < 1 )
    {
        
        [MBProgressHUD showAutoMessage:@"请输入手机号！"];
        return;
    }
    if( phone.length != 11 )
    {
        [MBProgressHUD showAutoMessage:@"请输入正确的手机号！"];
        return;
    }
    if (password.length<1) {
        [MBProgressHUD showAutoMessage:@"请输入密码！"];
        return;
    }
    
    
    //    appDelegate.tab = TabBarControllerConfig
    
    NSString *url;
    if (self.type == 0) {
        // 教练
        url=[NSString stringWithFormat:GETCoachmembersLogin,phone,password];
    }else{

        url=[NSString stringWithFormat:GETTeammembersLogin,phone,password];
    }
    [MBProgressHUD showLoadingHUD:@"正在登陆"];
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject) {
        [MBProgressHUD hideLoadingHUD];
        if ([responseObject[@"code"] integerValue] == 200) {
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"登录成功" SuccessOrFailure:YES];
            XLSingleton *sing = [XLSingleton singleton];
            [sing.dateArr removeAllObjects];
            [sing.practiceArr removeAllObjects];
            [sing.timeArr removeAllObjects];
            [sing.courseArr removeAllObjects];
            [alert showPrompt];
            [XLSingleton singleton].scanPhotoIp =responseObject[@"urliIp"];
            User *user=[User UserOb];
            
            user.type = [NSString stringWithFormat:@"%ld",(long)self.type];
            user.accounttype=[NSNumber numberWithInteger:accountTypePhone];
            [user UserSave:responseObject];
//            [[XLCache singleton] cacheWhitValue:responseObject[@"schoolList"] AndKey:SchoolList];
//            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:self.pho.text forKey:@"Loginaccount"];
            [defaults setObject:responseObject[@"schoolList"] forKey:SchoolList];
            [defaults synchronize];
            [UIWebView fm_setTokenToUIWebViewCookie]; //存token到域名cookie
            [self laodCacheData];
            NSArray *arr = responseObject[@"schoolList"];
            if (arr.count < 1) {
                SelectSchoolVC *vc = [[SelectSchoolVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
                CYLTabBarControllerConfig * TabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
                AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                appDelegate.tab = TabBarControllerConfig;
                appDelegate.window.rootViewController = TabBarControllerConfig.tabBarController;
                [self networkDidLogin];
            }
        }else{
            [MBProgressHUD showMsgHUD:responseObject[@"message"]];
        }
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideLoadingHUD];
        KKLog(@"error :%@",error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];

}




- (void)DSFlogin{
    XLPartyLoginV *v=[[XLPartyLoginV alloc]initWithFrame:CGRectMake(0, KFit_H6S(780), kScreenW, KFit_H6S(200))];
    v.vc=self;
    [self.view addSubview:v];
}

- (void)forgotpassword{
    ForgotPasswordVC *vc=[[ForgotPasswordVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//限制最大输入字数限制
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if (textField == _pho) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        if ([toBeString length] > 13) {
            
            return NO;
        }
    }
    if([string hasSuffix:@" "])     // 忽视空格
        return NO;
    else
        return YES;
    return YES;
}


#pragma mark -登录成功之后去获取各种缓存数据

- (void)laodCacheData{
    NSString *url = POSTAppDictList;
    [FMNetworkHelper fm_request_postWithUrlString:url isNeedCache:NO parameters:nil successBlock:^(id responseObject){
        if ([responseObject[@"code"] integerValue] == 200) {
            //把信息存起来
            NSUserDefaults *defaults  =  [NSUserDefaults standardUserDefaults];
            [defaults setObject:[responseObject[@"data"] mj_JSONString] forKey:@"AllData"];
            [defaults synchronize];
            
        }
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
    
}

- (void)networkDidLogin{
    
    User* bean = [User UserOb];
    if (bean.UserLogin) {
//        NSSet *set=[[NSSet alloc] initWithObjects:[NSString stringWithFormat:@"%@",bean.type], nil];
        NSString *str1=[NSString stringWithFormat:@"%@",bean.mobile];
        [JPUSHService setAlias:str1 completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            KKLog(@"rescode: %d,  \nalias: %@\n  seq:%d", iResCode, iAlias ,seq);
        } seq:1];
    }
    
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
