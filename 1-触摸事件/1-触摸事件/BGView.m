//
//  BGView.m
//  1-触摸事件
//
//  Created by shadandan on 16/8/10.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BGView.h"
#import "BlueView.h"
@interface BGView()
@property (weak, nonatomic) IBOutlet BlueView *blueView;
@end
@implementation BGView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
//实现在空白区域上移动鼠标时，蓝色view动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch=touches.anyObject;
    //获取上一次所在位置
    CGPoint p1=[touch previousLocationInView:self];
    //获取当前所在位置
    CGPoint p2=[touch locationInView:self];
    CGFloat moveX=p2.x-p1.x;
    CGFloat moveY=p2.y-p1.y;
    self.blueView.center=CGPointMake(self.blueView.center.x+moveX, self.blueView.center.y+moveY);
}
@end
