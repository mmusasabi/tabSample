//
//  Created by mmusasabi on 2014/10/31.
//  Copyright (c) 2014年 mmusasabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewController : UIViewController

//端末のスクリーン情報を持ってる
@property(readonly)CGRect screenRect;
@property(readonly)NSInteger screenW;
@property(readonly)NSInteger screenH;

@property(readonly)UIScrollView *tabScrollView;

@property(readwrite)NSInteger tabCount;
@property(readwrite)NSInteger nowSelected;

- (void)touch:(UIButton*)button;
- (id)getTabColor:(int)tabId;

- (id)getTabBackgroundColor;


@end

