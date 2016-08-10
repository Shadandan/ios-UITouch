//
//  BlueView.m
//  1-触摸事件
//
//  Created by shadandan on 16/8/10.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BlueView.h"

@implementation BlueView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%s",__func__);//%s是constant char *类型
//    NSSet *set=[NSSet setWithObjects:@"123",@(20),@"abc", nil];
//    NSLog(@"%@",set.anyObject);//随机输出一个，不是按顺序
//    for (id obj in set) {//123  abc  20
//        NSLog(@"%@",obj);
//    }
//    UITouch *touch=touches.anyObject;
//    NSLog(@"%ld",touch.tapCount);
//    CGPoint p=[touch locationInView:self];
//    NSLog(@"%@",NSStringFromCGPoint(p));
    //获取触摸对象
    UITouch *touch=touches.anyObject;
    //获取当前手指在父控件的位置
    CGPoint p=[touch locationInView:self.superview];
    //让蓝色view的center设成手指的位置
    self.center=p;
    
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     //NSLog(@"%s",__func__);
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     //NSLog(@"%s",__func__);
    //方法1：
//    UITouch *touch=touches.anyObject;
//    //获取当前手指在父控件的位置
//    CGPoint p=[touch locationInView:self.superview];
//    //让蓝色view的center设成手指的位置
//    self.center=p;
    //方法2：
    UITouch *touch=touches.anyObject;
    //获取当前手指在父控件的位置
    CGPoint p=[touch locationInView:self.superview];
    CGPoint p1=[touch previousLocationInView:self.superview];
    CGFloat moveX=p.x-p1.x;
    CGFloat moveY=p.y-p1.y;
    //让蓝色view的center设成手指的位置
    self.center=CGPointMake(self.center.x+moveX,self.center.y+moveY);

}
//非正常离开的时候调用，比如电话打扰
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     //NSLog(@"%s",__func__);
}

@end
