//
//  ViewController.m
//  VFL
//
//  Created by HanYong on 2020/7/2.
//  Copyright © 2020 HanYong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testConstraint];
    
}
- (void)testConstraint {//测试布局
    
    /*
     |:   表示父视图
     -:  表示距离
     V:  表示垂直
     H:  表示水平
     >=: 表示视图间距、宽度和高度必须大于或等于某个值
     <= :表示视图间距、宽度和高度必须小宇或等于某个值
     == :表示视图间距、宽度或者高度必须等于某个值
     @:  优先级 最大为  1000
     
     |-[view]-|:                          视图处在父视图的左右边缘内
     |-[view]  :                          视图处在父视图的左边缘
     |[view]   :                              视图和父视图左边对齐
     V:[view(100.)]  :                        设置视图的高度
     H:[view(100.)]  :                        设置视图的宽度
     |-30.0-[view]-30.0-|:                表示离父视图 左右间距  30
     |-[view(view1)]-[view1]-| :              View和view1视图宽度一样，并且在父视图内
     V:|-padding-[imageView]->=0-[button]-padding| : 表示离父视图的距离为Padding,这两个视图间距必须大于或等于0并且距离底部父视图为padding。此时必须对 metrics参数赋值eg.  metrics:@{@"topMargin":@100};

     [wideView(>=60@700)]  :视图的宽度为至少为60 优先级为700
     */

    UIView *supView1 = [[UIView alloc] init];
    supView1.backgroundColor =  [UIColor blueColor];
    
    UIView *supView2 = [[UIView alloc] init];
    supView2.backgroundColor =  [UIColor greenColor];

    [self.view addSubview:supView1];
    [self.view addSubview:supView2];
    
    //由于AutoLayout布局和Autoresizing布局是冲突的,因此要使用AutoLayout必须要关闭Autoresizing
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    supView2.translatesAutoresizingMaskIntoConstraints = NO;
    supView1.translatesAutoresizingMaskIntoConstraints = NO;
    
    //此语句的意思是 垂直方向: supView1距离父view的距离为 topMargin,
    //supView1的垂直方向的宽度为50.0, supView2距离supView1为20, 并且高度也为50.0;
    NSString *top = @"V:|-200-[supView1(100.0)]-20-[supView2(100.0)]";
    //解释方法同上
    NSString *left = @"H:|-10-[supView1(50.0)]";
    NSString *v2T = @"[supView2(60.0)]";
    
    
    //此处需要对topMargin参数进行解释, 其实就是给topMargin赋值;
    NSArray *s1T = [NSLayoutConstraint constraintsWithVisualFormat:top options:NSLayoutFormatAlignAllRight metrics:@{@"topMargin":@200} views:NSDictionaryOfVariableBindings(supView1, supView2)];

    NSArray *s1L = [NSLayoutConstraint constraintsWithVisualFormat:left options:0 metrics:nil views:NSDictionaryOfVariableBindings(supView1)];
    NSArray *v2Tc = [NSLayoutConstraint constraintsWithVisualFormat:v2T options:0 metrics:nil views:NSDictionaryOfVariableBindings(supView2)];
    
    //一般需要把约束添加到父view上
    [self.view addConstraints:v2Tc];
    [self.view addConstraints:s1T];
    [self.view addConstraints:s1L];

}


@end
