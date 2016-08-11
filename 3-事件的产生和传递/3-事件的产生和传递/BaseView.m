//
//  BaseView.m
//  3-事件的产生和传递
//
//  Created by shadandan on 16/8/11.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@-touchesBegan",[self class]);
    [super touchesBegan:touches withEvent:event];
}
-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    NSLog(@"%@-hitTest",[self class]);
    [super hitTest:point withEvent:event];
    return self;
}
@end
