//
//  BGView.m
//  2-多点触摸事件
//
//  Created by shadandan on 16/8/10.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BGView.h"
@interface BGView()
@property(nonatomic,strong)NSArray *array;
@end
@implementation BGView
//懒加载
-(NSArray *)array{
    if (!_array) {
        _array=@[@"spark.jpg",@"blueSpark.jpg"];
    }
    return _array;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addSpark:touches];
    
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
   [self addSpark:touches];

    
}
-(void)addSpark:(NSSet<UITouch *> *)touches{
    //UITouch *touch=touches.anyObject;
    int i=0;
    for (UITouch *touch in touches) {
        CGPoint p=[touch locationInView:self];
        //创建ImageView
        UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:self.array[i]]];
        imageView.frame=CGRectMake(p.x, p.y, 10, 10);
        //imageView.center=p;
        [self addSubview:imageView];
        [UIView animateWithDuration:0.5 animations:^{
            imageView.alpha=0;
            
        }completion:^(BOOL finished) {
            [imageView removeFromSuperview];
        }];
        i++;
    }
}
@end
