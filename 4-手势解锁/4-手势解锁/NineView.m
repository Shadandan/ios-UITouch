//
//  NineView.m
//  4-手势解锁
//
//  Created by shadandan on 16/8/11.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "NineView.h"
#define kButtonCount 9
@interface NineView()
@property(nonatomic,strong)NSMutableArray *btns;//9个按钮
@property(nonatomic,strong)NSMutableArray *lineBtns;//连线的按钮
@end
@implementation NineView
//懒加载
-(NSMutableArray *)btns{
    if (!_btns) {
        _btns=[NSMutableArray array];
        for (int i=0; i<kButtonCount; i++) {
            UIButton *btn=[[UIButton alloc]init];
            //btn.backgroundColor=[UIColor redColor];
            [btn setBackgroundImage:[UIImage imageNamed:@"lock_btn_none"] forState:UIControlStateNormal];
            //设置高亮的图片
            [btn setBackgroundImage:[UIImage imageNamed:@"lock_btn_sel"] forState:UIControlStateHighlighted];//发现松手就变回原来的状态了
            //所以关闭用户交互，让其不可点击，用touchesMove来实现
            btn.userInteractionEnabled=NO;
            [self addSubview:btn];
            [self.btns addObject:btn];
        }
    }
    return _btns;
}
-(NSMutableArray *)lineBtns{
    if (!_lineBtns) {
        _lineBtns=[NSMutableArray array];
    }
    return  _lineBtns;
}
//可以不在这里面创建，可以在懒加载中创建
//-(void)awakeFromNib{
//    for (int i=0; i<kButtonCount; i++) {
//        UIButton *btn=[[UIButton alloc]init];
//        btn.backgroundColor=[UIColor redColor];
//        [self addSubview:btn];
//        [self.btns addObject:btn];
//    }
//}


/*
 layoutSubviews在以下情况下会被调用：
 1、init初始化不会触发layoutSubviews
 2、addSubview会触发layoutSubviews
 3、设置view的Frame会触发layoutSubviews，当然前提是frame的值设置前后发生了变化
 4、滚动一个UIScrollView会触发layoutSubviews
 5、旋转Screen会触发父UIView上的layoutSubviews事件
 6、改变一个UIView大小的时候也会触发父UIView上的layoutSubviews事件
 */
//计算九宫格布局
-(void)layoutSubviews{
    [super layoutSubviews];
    //for (int i=0; i<self.btns.count; i++) {
        CGFloat w=74;
        CGFloat h=w;
        int colCount=3;
        CGFloat margin=(self.frame.size.width-colCount*w)/4;
        for (int i=0; i<self.btns.count; i++) {//调用懒加载，创建button
            CGFloat x=(i%colCount)*(margin+w)+margin;
            CGFloat y=(i/colCount)*(margin+h)+margin;
            [self.btns[i] setFrame:CGRectMake(x, y, w, h)];
        }
    //}
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch=touches.anyObject;
    //获取当前手指位置
    CGPoint p=[touch locationInView:touch.view];
    for (int i=0; i<self.btns.count; i++) {
        UIButton *btn=self.btns[i];
        
        //判断手指的位置是不是在btn的frame范围之内
        if(CGRectContainsPoint(btn.frame, p)){
            //如果是设置这个按钮高亮状态
            btn.highlighted=YES;
        }
    }
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸对象
    UITouch *touch=touches.anyObject;
    //获取当前手指位置
    CGPoint p=[touch locationInView:touch.view];
    for (int i=0; i<self.btns.count; i++) {
        UIButton *btn=self.btns[i];
        
        //判断手指的位置是不是在btn的frame范围之内
        if(CGRectContainsPoint(btn.frame, p)){
            //如果是设置这个按钮高亮状态
            btn.highlighted=YES;
            if(!([self.lineBtns containsObject:btn])){
                [self.lineBtns addObject:btn];//将btn加入要画线的数组中
            }
        }
    }
    //重绘
    [self setNeedsDisplay];

}

//画线
-(void)drawRect:(CGRect)rect{
    //创建路径
    UIBezierPath *path=[UIBezierPath bezierPath];
    for (int i=0; i<self.lineBtns.count; i++) {
        UIButton *btn=self.lineBtns[i];
        //如果i=0设置起点
        if(i==0){
            [path moveToPoint:btn.center];
            
        }else{//如果i不等于0，连线
            [path addLineToPoint:btn.center];
        }
    }
    //设置样式
    [[UIColor whiteColor]set];
    [path setLineWidth:10];
    //渲染
    [path stroke];
}


-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self clear];
    
}

//恢复到初始状态
-(void)clear{
    for (int i=0; i<self.btns.count; i++) {
        UIButton *btn=self.btns[i];
        btn.highlighted=NO;
    }
    //清空所有的画线数组
    [self.lineBtns removeAllObjects];
    //重绘
    [self setNeedsDisplay];
}
@end
