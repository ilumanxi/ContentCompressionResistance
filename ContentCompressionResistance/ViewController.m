//
//  ViewController.m
//  ContentCompressionResistance
//
//  Created by lumanxi on 15/10/23.
//  Copyright © 2015年 fanfan. All rights reserved.
//

#import "ViewController.h"


/**
 
 Content Hugging 和 Content Compression Resistance
 
 这两个属性对有intrinsic content size的控件（例如button，label）非常重要。通俗的讲，具有intrinsic content size的控件自己知道（可以计算）自己的大小，例如一个label，当你设置text，font之后，其大小是可以计算到的。关于intrinsic content size官方的解释：
 
 Custom views typically have content that they display of which the layout system is unaware. Overriding this method allows a custom view to communicate to the layout system what size it would like to be based on its content. This intrinsic size must be independent of the content frame, because there’s no way to dynamically communicate a changed width to the layout system based on a changed height, for example.
 好了，了解了intrinsic content size的概念之后，下面就重点讨论Content Hugging 和 Content Compression Resistance了。
 
 UIView中关于Content Hugging 和 Content Compression Resistance的方法有：
 
 - (UILayoutPriority)contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxis)axis
 - (void)setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis
 - (UILayoutPriority)contentHuggingPriorityForAxis:(UILayoutConstraintAxis)axis
 - (void)setContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis
 
 
 大概的意思就是设置优先级的。
 
 Hugging priority 确定view有多大的优先级阻止自己变大。
 
 Compression Resistance priority确定有多大的优先级阻止自己变小。
 
 很抽象，其实content Hugging就是要维持当前view在它的optimal size（intrinsic content size），可以想象成给view添加了一个额外的width constraint，此constraint试图保持view的size不让其变大：
 
 view.width <= optimal size
 
 此constraint的优先级就是通过上面的方法得到和设置的，content Hugging默认为250.
 
 Content Compression Resistance就是要维持当前view在他的optimal size（intrinsic content size），可以想象成给view添加了一个额外的width constraint，此constraint试图保持view的size不让其变小：
 view.width >= optimal size
 此默认优先级为750.
 
 
 
 */

@interface ViewController ()

{
    UIButton *button1;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    [self ContentCompressionResistance];
}


- (void)ContentHugging{
    
    button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 setTitle:@"button 1 button 2" forState:UIControlStateNormal];
    [button1 sizeToFit];
    button1.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:button1];
    
     //使其距离顶部100，距离左边100，距离右边10，注意右边
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-10.0f];
    
   //代码很容易理解，创建一个button，设置其constraint，使其距离顶部100，距离左边100，距离右边10，注意右边的constraint的优先级我们设置的为750.0，此时autolayout系统会去首先满足此constraint，再去满足Content Hugging（其优先级为250，小于251）
//    constraint.priority = UILayoutPriorityDefaultHigh;
    
    //当把优先级priority改为249的时候，
    // 这时就是先满足了Content Hugging的constraint，因为其优先级高。
//    constraint.priority = UILayoutPriorityDefaultLow - 1;
    [self.view addConstraint:constraint];
    
    
}



- (void)ContentCompressionResistance
{
    
    button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 setTitle:@"button 1 button 2" forState:UIControlStateNormal];
    [button1 sizeToFit];
    button1.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:button1];
    
    //使其距离顶部100，距离左边100，距离右边160，注意右边
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.0f];
    [self.view addConstraint:constraint];
    
    
    constraint = [NSLayoutConstraint constraintWithItem:button1 attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:-160.0f];
    
    //代码很容易理解，创建一个button，设置其constraint，使其距离顶部100，距离左边100，距离右边150，注意右边的constraint的优先级我们设置的为751.0，此时autolayout系统会去首先满足此constraint，再去满足Content Compression Resistance（其优先级为750，小于751）。
//    constraint.priority = 751.0f;
    
    
    
    //当我们把751变为749的时候，效果如下：
    // 这时就是先满足了Content Compression Resistance的constraint，因为其优先级高。

//    constraint.priority = 749.0f;
    
    [self.view addConstraint:constraint];

}


@end
