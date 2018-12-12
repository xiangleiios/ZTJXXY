//
//  MyCourse.m
//  MobileProject
//
//  Created by 向蕾 on 2018/12/12.
//  Copyright © 2018年 ZSGY. All rights reserved.
//

#import "MyCourse.h"

@implementation MyCourse

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self loadSubview];
    }
    return self;
}

- (void)loadSubview{
    UILabel *lb = [[UILabel alloc] init];
    [self addSubview:lb];
    lb.backgroundColor = kColor_N(0, 97, 233);
    [lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.mas_equalTo(self).mas_offset(KFit_W6S(30));
        make.width.mas_equalTo(KFit_W6S(10));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    UILabel *lbtitle = [[UILabel alloc] init];
    [self addSubview:lbtitle];
    lbtitle.text = @"我正在学";
    lbtitle.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.5];
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.height.mas_equalTo(lb);
        make.left.mas_equalTo(lb.mas_right).mas_offset(KFit_W6S(10));
        make.width.mas_equalTo(KFit_W6S(200));
    }];
    
    UIImageView *img = [[UIImageView alloc] init];
    [self addSubview:img];
    [img setImage:[UIImage imageNamed:@"my_bg_card"]];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(lbtitle.mas_bottom).mas_offset(KFit_H6S(30));
        make.size.mas_equalTo(CGSizeMake(KFit_W6S(690), KFit_H6S(246)));
    }];
    
    self.title = [[UILabel alloc] init];
    [img addSubview:self.title];
    self.title.textColor = [UIColor whiteColor];
    self.title.font = [UIFont systemFontOfSize:kFit_Font6(16) weight:0.5];
    self.title.text = @"wodedaewaddasfdf";
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(img).mas_offset(KFit_H6S(50));
        make.left.mas_equalTo(img).mas_offset(KFit_H6S(30));
        make.right.mas_equalTo(img).mas_offset(-KFit_H6S(30));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    self.address = [[UILabel alloc] init];
    [img addSubview:self.address];
    self.address.textColor = [UIColor whiteColor];
    self.address.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    self.address.text = @"wodedaewaddasfdf";
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.title.mas_bottom).mas_offset(KFit_H6S(30));
        make.left.mas_equalTo(img).mas_offset(KFit_H6S(30));
        make.right.mas_equalTo(img).mas_offset(-KFit_H6S(200));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    
    self.time = [[UILabel alloc] init];
    [img addSubview:self.time];
    self.time.textColor = [UIColor whiteColor];
    self.time.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    self.time.text = @"wodedaewaddasfdf";
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.address.mas_bottom).mas_offset(KFit_H6S(20));
        make.left.mas_equalTo(img).mas_offset(KFit_H6S(30));
        make.right.mas_equalTo(img).mas_offset(-KFit_H6S(200));
        make.height.mas_equalTo(KFit_H6S(30));
    }];
    
    
    UILabel *lbtype = [[UILabel alloc] init];
    [img addSubview:lbtype];
    lbtype.textColor = [UIColor whiteColor];
    lbtype.font = [UIFont systemFontOfSize:kFit_Font6(14)];
    lbtype.text = @"已报名";
    lbtype.textAlignment = NSTextAlignmentCenter;
    lbtype.layer.cornerRadius = KFit_H6S(20);
    lbtype.layer.borderColor = [UIColor whiteColor].CGColor;
    lbtype.layer.borderWidth = 0.5;
    [lbtype mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.time);
        make.width.mas_equalTo(KFit_W6S(110));
        make.right.mas_equalTo(img).mas_offset(-KFit_H6S(40));
        make.height.mas_equalTo(KFit_H6S(40));
    }];
    
}

@end
