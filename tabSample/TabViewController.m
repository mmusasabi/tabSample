//
//  Created by mmusasabi on 2014/10/31.
//  Copyright (c) 2014年 mmusasabi. All rights reserved.
//


#import "TabViewController.h"
#import "tabVIew.h"

@interface TabViewController ()

@end

#define STATUS_BAR_SIZE 20
#define LABEL_TAG 100
#define UNDER_BAR_TAG 200

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadScreenSize];

    _tabCount = 10;
    
    //スクロールビュー生成
    _tabScrollView = [[UIScrollView alloc] initWithFrame:
                   CGRectMake(0, STATUS_BAR_SIZE, self.view.bounds.size.width, _screenH/9)];
    _tabScrollView.bounces = NO;
    _tabScrollView.contentSize = CGSizeMake((_screenW/4)*_tabCount, _screenH/9);
    
    NSArray *tabList = @[@"1", @"2", @"3", @"4", @"5",
                         @"6", @"7", @"8", @"9", @"10"];
    
    for (int i = 1; i <= _tabCount; i++) {
        UIButton *tab = [[tabVIew alloc]initWithFrame:CGRectMake(_screenW/4 * (i-1), 0, _screenW/4, _screenH/9) :i :tabList[i-1]];
        tab.tag = i;
        [tab addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
        [_tabScrollView addSubview:tab];
        
        if (i == 1) {//最初のタブをクリック済みにする。
            [self touch:tab];
            _nowSelected = 1;
        }
    }
    
    
    //ViewにTabViewを追加
    [self.view addSubview:_tabScrollView];
    
    //メインビューに下部バーを追加
    UIView *underBar = [[UIView alloc]init];
    underBar.frame = CGRectMake(0, (_screenH/9) + STATUS_BAR_SIZE - 5, _screenW, 5);
    underBar.tag = UNDER_BAR_TAG;
    [underBar setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:underBar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//-----------------------------
#pragma mark - PRIVATE METHODS
//-----------------------------

-(void)loadScreenSize{
    _screenRect = [[UIScreen mainScreen] bounds];
    _screenW = _screenRect.size.width;
    _screenH = _screenRect.size.height;
    
}


- (void)touch:(UIButton*)button{
    //Debug
    NSLog(@"タブ番号：%d　をタップしました。",(int)button.tag);
    if (button.tag != _nowSelected) {
        UIView* selectedTabButton = [self.view viewWithTag: _nowSelected];
        [self moveTab:button];
        [self returnSelectedColor:selectedTabButton];
        [self changeSelectColor:button];
        _nowSelected = button.tag;
    }
}

//タブの位置をいい感じのポイントへ動かす
- (void)moveTab:(UIButton*)button{
    CGPoint offset;
    if ( button.tag <= 2 ) {
        offset.x = 0;//左端に寄せる
    } else if ( button.tag > _tabCount - 2 ) {
        offset.x = _screenW/4 * (_tabCount - 4);//右端に寄せる
    } else {
        offset.x = _screenW/4 * (button.tag - 2.5);
    }
    offset.y = 0;
    [_tabScrollView setContentOffset:offset animated:YES];
}


//選択していたタブの色を元に戻す。
- (void)returnSelectedColor:(UIView*)button{
    UILabel *tabName = (UILabel*)[button viewWithTag:(LABEL_TAG + button.tag)];
    button.BackgroundColor  = [self getTabBackgroundColor];
    tabName.textColor       = [self getTabColor:(int)button.tag];
}

//タップされたタブの色を変化させる。
- (void)changeSelectColor:(UIButton*)button{
    UIView *underBar = [self.view viewWithTag:(UNDER_BAR_TAG)];
    button.backgroundColor   = [self getTabColor:(int)button.tag];
    underBar.backgroundColor = [self getTabColor:(int)button.tag];
    
    UILabel *tabName;
    tabName = (UILabel*)[button viewWithTag:(LABEL_TAG + button.tag)];
    tabName.textColor = [UIColor whiteColor];
}

- (id)getTabColor:(int)tabId{
    UIColor *tabColor;
    switch (tabId % 5) {
        case 1:
            tabColor = [UIColor redColor];
            break;
        case 2:
            tabColor = [UIColor orangeColor];
            break;
        case 3:
            tabColor = [UIColor greenColor];
            break;
        case 4:
            tabColor = [UIColor blueColor];
            break;
        default:
            tabColor = [UIColor purpleColor];
            break;
    }
    return  tabColor;
}

- (id)getTabBackgroundColor
{
    UIColor *tabColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];
    return  tabColor;
}
@end
