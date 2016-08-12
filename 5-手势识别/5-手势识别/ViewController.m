//
//  ViewController.m
//  5-手势识别
//
//  Created by shadandan on 16/8/12.
//  Copyright © 2016年 SDD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    /*
    1.创建手势对象
    2.把手势添加到某一个view上
    3.实现手势执行的回调
     */
    
    // UITapGestureRecognizer敲击
    //@property (nonatomic) NSUInteger  numberOfTapsRequired;       // Default is 1. The number of taps required to match
    //@property (nonatomic) NSUInteger  numberOfTouchesRequired __TVOS_PROHIBITED;    // Default is 1. The number of fingers required to match
    //1.创建手势对象
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired=2;//表示要点击两次才会反应
    //2.把手势添加到某一个view上
    [self.imageView addGestureRecognizer:tap];
    
    //UILongPressGestureRecognizer  长按,默认是长按执行一次，松手又执行一次
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    longPress.minimumPressDuration=2;//要求长按多长时间
    longPress.allowableMovement=5;//设置手指移动误差范围（默认是10像素）
    [self.imageView addGestureRecognizer:longPress];
    
    //UISwipeGestureRecognizer 轻扫，默认的方向是从左往右的
    UISwipeGestureRecognizer *swipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    UISwipeGestureRecognizer *swipe1=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipe1.direction=UISwipeGestureRecognizerDirectionLeft;//方向设置的是划向那边，还可以设置上下
    [self.imageView addGestureRecognizer:swipe];
    [self.imageView addGestureRecognizer:swipe1];
    
    //UIRotationGestureRecognizer旋转
    UIRotationGestureRecognizer *rotation=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    [self.imageView addGestureRecognizer:rotation];
    rotation.delegate=self;//设置代理，为了解决旋转和缩放不能同时进行的bug
    
    // UIPinchGestureRecognizer捏合(用于缩放)
    UIPinchGestureRecognizer *pinch=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinch:)];
    [self.imageView addGestureRecognizer:pinch];
    pinch.delegate=self;//设置代理，为了解决旋转和缩放不能同时进行的bug
    
    // UIPanGestureRecognizer拖拽
    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];


}
 //3.实现手势执行的回调
-(void)tap:(UITapGestureRecognizer *)sender{
    NSLog(@"tap...");
}
-(void)longPress:(UILongPressGestureRecognizer *)sender{
    //通过判断状态来实现，仅仅是长按点下去的时候才执行代码，松手后不再执行一次，
    if(sender.state==UIGestureRecognizerStateBegan){
        NSLog(@"longPress...");
    }
}
-(void)swipe:(UISwipeGestureRecognizer *)sender{
    if(sender.direction==UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"swipeLeft...");
    }else{
        NSLog(@"swipeRight...");
    }
    
}
-(void)rotation:(UIRotationGestureRecognizer *)sender{
    //rotation属性，表示旋转的角度
    NSLog(@"%f",sender.rotation);
    //self.imageView.transform=CGAffineTransformMakeRotation(sender.rotation);
    self.imageView.transform=CGAffineTransformRotate(self.imageView.transform, sender.rotation);
    sender.rotation=0;//归零，回传过来的是每一次旋转的角度
}
-(void)pinch:(UIPinchGestureRecognizer *)sender{
    //rotation属性，表示旋转的角度
    NSLog(@"%f",sender.scale);
    
    self.imageView.transform=CGAffineTransformScale(self.imageView.transform, sender.scale, sender.scale);
    sender.scale=1;//归零，回传过来的是每一次变化的比例
}
-(void)pan:(UIPanGestureRecognizer *)sender{
    //获取拖拽的偏移量
    CGPoint p=[sender translationInView:sender.view];
    self.imageView.transform=CGAffineTransformTranslate(self.imageView.transform, p.x, p.y);
    [sender setTranslation:CGPointZero inView:self.imageView];//归零
}
//实现代理方法，设置两个手势可以同时响应
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
