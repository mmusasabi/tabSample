//
//  Created by mmusasabi on 2014/10/31.
//  Copyright (c) 2014年 mmusasabi. All rights reserved.
//


#import "tabVIew.h"
#import "TabViewController.h"

#define LABEL_TAG 100

@implementation tabVIew

-(id)initWithFrame:(CGRect)frame:(int)tabId:(NSString*)tabLabelName
{
    self = [super initWithFrame:frame];
    self = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    
    [self setFrame:CGRectMake(frame.size.width * (tabId-1), 0, frame.size.width, frame.size.height)];
    self.backgroundColor = [[TabViewController alloc]getTabBackgroundColor];
    
    //ラベルの貼り付け
    UILabel *label;
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-5)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    label.tag = LABEL_TAG + tabId;
    label.textColor = [[TabViewController alloc]getTabColor:tabId];
    [label setText:tabLabelName];
    [self addSubview:label];
    
    return self;
}

@end
