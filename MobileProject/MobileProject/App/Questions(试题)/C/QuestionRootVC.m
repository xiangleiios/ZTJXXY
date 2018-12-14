//
//  QuestionRootVC.m
//  MobileProject
//
//  Created by 向蕾 on 2018/12/12.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "QuestionRootVC.h"

@interface QuestionRootVC ()
@property (nonatomic , strong)UIScrollView *scroll;
@property (nonatomic ,strong)XLView *backView;

@property (nonatomic , strong)UIButton *SubjectOne;
@property (nonatomic , strong)UIButton *Subjectfour;
@property (nonatomic , strong)UIButton *selectBut;
@property (nonatomic , strong)UILabel *selectLB;

@property (nonatomic , strong)UILabel *question;
@property (nonatomic , strong)UILabel *questionAll;
@property (nonatomic , strong)UILabel *score;//分数

@property (nonatomic , strong)UIButton *functionButOne;
@property (nonatomic , strong)UIButton *functionButTwo;

@end

@implementation QuestionRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self laodNavigation];
    
    [self loadScroll];
    
    [self loadSubview];
    // Do any additional setup after loading the view.
}
#pragma mark - 导航相关
- (void)laodNavigation{
    [self.navigationView setNavigationBackgroundAlpha:0];
    self.navigationView.lineView.hidden = YES;
}

- (void)loadScroll{
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
    }];
    /// 顶部对齐问题
    self.scroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.backView = [[XLView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.scroll addSubview:self.backView];
    
}

- (void)loadSubview{
    UILabel *titleLB = [[UILabel alloc] init];
    [self.backView addSubview:titleLB];
    titleLB.text = @"试题";
    titleLB.font = [UIFont systemFontOfSize:kFit_Font6(25) weight:0.6];
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.backView).mas_offset(KFit_H6S(100));
        make.left.mas_equalTo(self.backView).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(200), KFit_H6S(60)));
    }];
    
    self.SubjectOne = [[UIButton alloc] initWithFrame:CGRectMake(KFit_W6S(150), KFit_H6S(200), KFit_W6S(80), KFit_H6S(50))];
    [self.SubjectOne setTitle:@"科一" forState:UIControlStateNormal];
    [self.SubjectOne setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.SubjectOne.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.3];
    [self.backView addSubview:self.SubjectOne];
    
    self.Subjectfour = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - KFit_W6S(80) - KFit_W6S(150), KFit_H6S(200), KFit_W6S(80), KFit_H6S(50))];
    [self.Subjectfour setTitle:@"科四" forState:UIControlStateNormal];
    [self.Subjectfour setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.Subjectfour.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.3];
    [self.backView addSubview:self.Subjectfour];
    
    self.selectBut = self.SubjectOne;
    
    self.selectLB = [[UILabel alloc] initWithFrame:CGRectMake(KFit_W6S(150), KFit_H6S(260), KFit_W6S(80), KFit_H6S(6))];
    [self.backView addSubview:self.selectLB];
    self.selectLB.backgroundColor = [UIColor blackColor];
    
    
    UIImageView *img = [[UIImageView alloc] init];
    img.userInteractionEnabled = YES;
    [self.backView addSubview:img];
    [img setImage:[UIImage imageNamed:@"photo_bg"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.SubjectOne.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(self.backView);
        make.height.mas_equalTo(KFit_H6S(588));
    }];
    
    UILabel *lbone = [[UILabel alloc] init];
    lbone.text = @"顺序练习";
    lbone.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.1];
    [img addSubview:lbone];
    [lbone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(img).mas_offset(KFit_W6S(80));
        make.centerY.mas_equalTo(img).mas_offset(KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(200), KFit_H6S(40)));
    }];
    
    
    UILabel *lbtwo = [[UILabel alloc] init];
    [img addSubview:lbtwo];
    lbtwo.text = @"模拟考试";
    lbtwo.font = [UIFont systemFontOfSize:kFit_Font6(18) weight:0.1];
    [lbtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lbone);
        make.centerX.mas_equalTo(self.backView).mas_offset(KFit_W6S(200));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(200), KFit_H6S(40)));
    }];
    
    self.question = [[UILabel alloc] init];
    [img addSubview:self.question];
    self.question.font = [UIFont systemFontOfSize:kFit_Font6(25) weight:0.2];
    self.question.textColor = kColor_N(0, 105, 233);
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbone);
        make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(55));
    }];
    self.question.text = @"150";
    
    self.questionAll = [[UILabel alloc] init];
    [img addSubview:self.questionAll];
    self.questionAll.font = [UIFont systemFontOfSize:kFit_Font6(25) weight:0.2];
    [self.questionAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.question.mas_right);
        make.top.mas_equalTo(lbone.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(55));
    }];
    self.questionAll.text = @"/1350";
    
    self.score = [[UILabel alloc] init];
    [img addSubview:self.score];
    self.score.font = [UIFont systemFontOfSize:kFit_Font6(25) weight:0.2];
    self.score.textColor = kColor_N(0, 105, 233);
    [self.score mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbtwo);
        make.top.mas_equalTo(lbtwo.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_H6S(55));
    }];
    self.score.text = @"0";
    
    UILabel *lbthree = [[UILabel alloc] init];
    [img addSubview:lbthree];
    lbthree.text = @"分";
    lbthree.font = [UIFont systemFontOfSize:kFit_Font6(15)];
    [lbthree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.score.mas_right);
        make.bottom.mas_equalTo(self.score.mas_bottom);
        make.height.mas_equalTo(KFit_H6S(45));
    }];
    
    UIButton *butone = [[UIButton alloc] init];
    [img addSubview:butone];
    butone.tag = 1;
    [butone setImage:[UIImage imageNamed:@"qulianxi"] forState:UIControlStateNormal];
    [butone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbone).mas_offset(-KFit_W6S(20));
        make.top.mas_equalTo(self.question.mas_bottom).mas_offset(KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(218), KFit_H6S(118)));
    }];
    
    UIButton *buttwo = [[UIButton alloc] init];
    [img addSubview:buttwo];
    buttwo.tag = 2;
    [buttwo setImage:[UIImage imageNamed:@"qukaoshi"] forState:UIControlStateNormal];
    [buttwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lbtwo).mas_offset(-KFit_W6S(20));
        make.top.mas_equalTo(self.questionAll.mas_bottom).mas_offset(KFit_H6S(20));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(218), KFit_H6S(118)));
    }];
    
    UIImageView *imgtwo = [[UIImageView alloc] init];
    [self.backView addSubview:imgtwo];
    [imgtwo setImage:[UIImage imageNamed:@"my_bg_white"]];
    [imgtwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img.mas_bottom);
        make.left.right.mas_equalTo(self.backView);
        make.height.mas_equalTo(KFit_H6S(260));
    }];
    
    
    XLxqbut *but_one = [[XLxqbut alloc] init];
//    [but_one addTarget:self action:@selector(toZhaosheng) forControlEvents:UIControlEventTouchUpInside];
    [but_one setImage:[UIImage imageNamed:@"wrong"] forState:UIControlStateNormal];
    [but_one setTitle:@"我的错题" forState:UIControlStateNormal];
    [but_one setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but_one.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.3];
    
    XLxqbut *but_two = [[XLxqbut alloc] init];
//    [but_two addTarget:self action:@selector(toMingpan) forControlEvents:UIControlEventTouchUpInside];
    [but_two setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [but_two setTitle:@"收藏夹" forState:UIControlStateNormal];
    [but_two setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but_two.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.2];
    
    XLxqbut *but_three = [[XLxqbut alloc] init];
//    [but_three addTarget:self action:@selector(toAddStudent) forControlEvents:UIControlEventTouchUpInside];
    [but_three setImage:[UIImage imageNamed:@"random"] forState:UIControlStateNormal];
    [but_three setTitle:@"随机练习" forState:UIControlStateNormal];
    [but_three setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but_three.titleLabel.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.2];
    
    
    [imgtwo addSubview:but_one];
    [imgtwo addSubview:but_two];
    [imgtwo addSubview:but_three];
    
    NSArray *toolarr = @[but_one,but_two,but_three];
    [toolarr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(140) leadSpacing:KFit_W6S(90) tailSpacing:KFit_W6S(90)];
    [toolarr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(imgtwo).mas_offset(-KFit_H6S(20));
        make.height.mas_equalTo(KFit_W6S(150));
    }];
    
    
    
    UIImageView *imgtitle = [[UIImageView alloc] init];
    [self.backView addSubview:imgtitle];
    [imgtitle setImage:[UIImage imageNamed:@"table"]];
    [imgtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.backView).mas_offset(KFit_W6S(30));
        make.top.mas_equalTo(imgtwo.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(150), KFit_H6S(45)));
    }];
    
    self.functionButOne = [[UIButton alloc] init];
    [self.functionButOne setImage:[UIImage imageNamed:@"examination"] forState:UIControlStateNormal];
    
    self.functionButTwo = [[UIButton alloc] init];
    [self.functionButTwo setImage:[UIImage imageNamed:@"skill"] forState:UIControlStateNormal];
    
    [self.backView addSubview:self.functionButOne];
    [self.backView addSubview:self.functionButTwo];
    
    NSArray *arr = @[self.functionButOne,self.functionButTwo];
    [arr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:KFit_W6S(330) leadSpacing:KFit_W6S(30) tailSpacing:KFit_W6S(30)];
    [arr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imgtitle.mas_bottom).mas_offset(KFit_H6S(20));
        make.height.mas_equalTo(KFit_W6S(165));
    }];
    
    
}












- (void)viewDidLayoutSubviews{
    self.backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.backView getLayoutCellHeightWithFlex:KFit_H6S(30)]);
    self.scroll.contentSize = CGSizeMake(0, CGRectGetMaxY(self.backView.frame));
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
