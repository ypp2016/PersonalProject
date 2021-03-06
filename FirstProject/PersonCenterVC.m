//
//  PersonCenterVC.m
//  FirstProject
//
//  Created by MacBook Air on 17/11/3.
//  Copyright © 2017年 BJ. All rights reserved.
//

#import "PersonCenterVC.h"
#import "PCTableViewCell.h"
#import "FourButtonTableViewCell.h"
#import "UIViewController+AlertTool.h"
#import "FQLLoginVC.h"
#import "SettingVC.h"

@interface PersonCenterVC ()<UITableViewDelegate,UITableViewDataSource, BringBackUserNameDelegate>
//tableVIew
@property(nonatomic,strong)UITableView *tableView;
//headView
@property(nonatomic,strong)UIView *tableViewHeaderView;
//背景大图
@property (nonatomic, strong)UIImageView *topBigIV;

@property (nonatomic, assign) BOOL statusBarStyleControl;
//头像
@property (nonatomic, strong)UIImageView *headPortraitIV;
//用户名
@property (nonatomic, strong)UILabel *userNameLabel;
//用户简介
@property (nonatomic, strong)UILabel *userIntroductionLabel;


@end

@implementation PersonCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackgroundColor;
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    [self setUpUI];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    if ([userDefaults boolForKey:@"status"]) {
//        NSLog(@"He logined!");
//        self.userNameLabel.text = [userDefaults objectForKey:@"userName"];
//        self.userNameLabel.textColor = [UIColor blackColor];
//    }else {
//        NSLog(@"Did not login now!");
//        self.userNameLabel.text = @"未登录";
//        self.userNameLabel.textColor = [UIColor darkGrayColor];
//    }
}

#pragma mark Tool Methods
- (void)setUpUI {
    [self.navigationController.navigationBar setTranslucent:YES];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self tableView];
    [self topBigIV];
    [self headPortraitIV];
    [self userNameLabel];
    [self userIntroductionLabel];
    //导航栏右边的设置控件
    UIBarButtonItem *settingItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"设置"] style:UIBarButtonItemStylePlain target:self action:@selector(goToSettingPage)];
    [self.navigationItem setRightBarButtonItem:settingItem];
}

- (void)goToSettingPage {
    SettingVC *settingVC = [SettingVC new];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (UIColor *)randomColor {
    float rColor = arc4random() % 255;
    float gColor = arc4random() % 255;
    float bColor = arc4random() % 255;
    return [UIColor colorWithRed:rColor / 255 green:gColor / 255 blue:bColor / 255 alpha:1];
}

- (void)loginMethod {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    //判断是否已经是登录状态
    if(![userDefault boolForKey:@"status"]) {
        //未登录，跳出登录页面
        FQLLoginVC *loginVC = [FQLLoginVC new];
        loginVC.delegate = self;
        [self.navigationController presentViewController:loginVC animated:YES completion:^{
            //
        }];
    }else {
        //已登录，进入个人信息页面
    }
}

- (void)goToCollectionedPage {
    NSLog(@"collectioned");
}

- (void)goToCommentsPage {
    NSLog(@"CommentsPage");
}

- (void)goToLikedPage {
    NSLog(@"LikedPage");
}

- (void)goToSharedPage {
    NSLog(@"SharedPage");
}

#pragma mark UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 3;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //第一个section
        FourButtonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fourButtonCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"FourButtonTableViewCell" owner:self options:nil].firstObject;
        }
        [cell.collectedNum addTarget:self action:@selector(goToCollectionedPage) forControlEvents:UIControlEventTouchUpInside];
        [cell.comments addTarget:self action:@selector(goToCommentsPage) forControlEvents:UIControlEventTouchUpInside];
        [cell.likedNum addTarget:self action:@selector(goToLikedPage) forControlEvents:UIControlEventTouchUpInside];
        [cell.sharedNum addTarget:self action:@selector(goToSharedPage) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1){
        //第二个section
        PCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pcCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PCTableViewCell" owner:self options:nil].firstObject;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 0) {
            
            cell.iconIV.image = [UIImage imageNamed:@"remind_fill"];
            cell.titleLabel.text = @"消息";
        }else if(indexPath.row == 1) {
            
            cell.titleLabel.text = @"购物车";
            cell.iconIV.image = [UIImage imageNamed:@"publish goods_fill"];
        }else if( indexPath.row == 2) {
            
            
            cell.titleLabel.text = @"帮助";
            cell.iconIV.image = [UIImage imageNamed:@"feedback_fill"];
        }
        
        return cell;
    } else if(indexPath.section == 2) {
        //第三个section
        PCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"pcCell"];
        if (!cell) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"PCTableViewCell" owner:self options:nil].firstObject;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 0) {
            cell.titleLabel.text = @"我的文章";
            cell.iconIV.image = [UIImage imageNamed:@"createtask_fill"];
        }else if(indexPath.row == 1) {
            cell.rightLabel.hidden = NO;
            cell.rightLabel.text = [NSString stringWithFormat:@"1.3M"];
            cell.titleLabel.text = @"清除缓存";
            cell.iconIV.image = [UIImage imageNamed:@"trash_fill"];
        }else if(indexPath.row == 2) {
            cell.rightLabel.hidden = YES;
            cell.titleLabel.text = @"其他";
            cell.iconIV.image = [UIImage imageNamed:@"marketing_fill"];
        }
        return cell;
    }else {
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 1 && indexPath.row == 0){
        NSLog(@"something else?");
    }else if(indexPath.section == 1 && indexPath.row == 1){
        
    }else if(indexPath.section == 1 && indexPath.row == 2){
        NSLog(@"something else?");
    }
    
    if(indexPath.section == 2 && indexPath.row == 0){
        NSLog(@"something else?");
    }else if(indexPath.section == 2 && indexPath.row == 1){
        [self presentAlertWithTitle:@"提示" message:@"确认清除缓存?" alertStyle:UIAlertControllerStyleAlert cancleActionTitle:@"取消" cancelBlock:nil sureActionTitle:@"确定" sureBlock:^{
            //TODO...
            PCTableViewCell *cell = (PCTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            cell.rightLabel.text = @"0.0M";
        } completion:nil];
    }else if(indexPath.section == 2 && indexPath.row == 2){
        NSLog(@"something else?");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 85;
    }else {
        return 55;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offsetY = scrollView.contentOffset.y;
    NSLog(@"---%f---", offsetY);
    if (offsetY < -300) {
        
        [self.topBigIV updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(offsetY);
            make.height.mas_equalTo(-offsetY );
        }];
        [self.topBigIV layoutIfNeeded];

//        下面是用frame的形式
//        CGRect rect = self.topBigIV.frame;
//        rect.origin.y = offsetY;
//        rect.size.height = -offsetY;
//        self.topBigIV.frame = rect;
    
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(- ysTabBarHeight);
        }];
        //注册cell
        [_tableView registerNib:[UINib nibWithNibName:@"PCTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"pcCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"FourButtonTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"fourButtonCell"];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor clearColor];
        //去掉cell之间的横线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //设置顶部的偏移量
        _tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0);
        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, CGFLOAT_MIN)];
        
        [_tableView setContentOffset:CGPointMake(0, -300)];
    }
    return _tableView;
}

- (UIImageView *)topBigIV {
    if (!_topBigIV) {
        _topBigIV = [[UIImageView alloc]init];
        [self.tableView addSubview:_topBigIV];
        [_topBigIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.top.mas_equalTo(-300);
            make.height.mas_equalTo(300);
        }];
        _topBigIV.contentMode = UIViewContentModeScaleAspectFill;
        _topBigIV.clipsToBounds = YES;
        _topBigIV.image = [UIImage imageNamed:@"pcImage"];
    }
    return _topBigIV;
}

- (UIImageView *)headPortraitIV {
    if (!_headPortraitIV) {
        _headPortraitIV = [[UIImageView alloc]init];
        [self.tableView addSubview:_headPortraitIV];
        [self.topBigIV.superview layoutIfNeeded];
        [_headPortraitIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(ysTopHeight - 300);
            make.height.width.mas_equalTo(100);
        }];
        _headPortraitIV.backgroundColor = MAIN_COLOR;
        //绘制圆角
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        [layer setFrame:CGRectMake(0, 0, 100, 100)];
        layer.path = path.CGPath;
        _headPortraitIV.layer.mask = layer;
        //设定图片
        _headPortraitIV.image = [UIImage imageNamed:@"头像"];
        _headPortraitIV.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(loginMethod)];
        [_headPortraitIV addGestureRecognizer:tapGesture];
        
    }
    return _headPortraitIV;
}

- (UILabel *)userNameLabel {
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc]init];
        [self.tableView addSubview:_userNameLabel];
        [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.headPortraitIV.mas_bottom).mas_offset(20);
        }];
        //设置文字颜色
        _userNameLabel.textColor = [UIColor whiteColor];
        
        //赋值
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if ([ud stringForKey:@"userName"] == nil) {
            //未登录
            _userNameLabel.text = DEFAULT_USER_NAME;
        }else {
            _userNameLabel.text = [ud stringForKey:@"userName"];
        }
    }
    return _userNameLabel;
}

- (UILabel *)userIntroductionLabel {
    if (!_userIntroductionLabel) {
        _userIntroductionLabel = [[UILabel alloc]init];
        [self.tableView addSubview:_userIntroductionLabel];
        [_userIntroductionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.userNameLabel.mas_bottom).offset(20);
            make.left.mas_equalTo(50);
            make.right.mas_equalTo(50);
        }];
        _userIntroductionLabel.textColor = BackgroundColor;
        _userIntroductionLabel.font = [UIFont systemFontOfSize:15];
        _userIntroductionLabel.numberOfLines = 2;
        _userIntroductionLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _userIntroductionLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    _userIntroductionLabel.text = @"欲买桂花同载酒  终不似  少年游";
    return _userIntroductionLabel;
}


@end
