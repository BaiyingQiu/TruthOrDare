//
//  ViewController.m
//  Truth or Dare
//
//  Created by Tarena on 16/5/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "ViewController.h"
#import "subViewController.h"
#import "UIView+DCAnimationKit.h"

@interface ViewController ()
//题目等级选择按钮
@property (weak, nonatomic) IBOutlet UIButton *isAdvancedButton;
@property (weak, nonatomic) IBOutlet UILabel *LVLable;
@property (weak, nonatomic) IBOutlet UIButton *tureButton;
@property (weak, nonatomic) IBOutlet UIButton *dareButton;
@property (weak, nonatomic) IBOutlet UIImageView *tipImageView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    UIImageView *launchView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    //    launchView.image = [UIImage imageNamed:@"background"];
    //    [self.view addSubview:launchView];
    //    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
    //        launchView.alpha = 0.0f;
    //        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
    //    } completion:^(BOOL finished) {
    //        [launchView removeFromSuperview];
    //    }];
    

    
}
- (void)swipenack {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickButtonGoSunView:(UIButton *)sender {
    subViewController *subVC = [[subViewController alloc] init];
    subVC.buttonTag = sender.tag;
    subVC.isAdvanced = self.isAdvancedButton.selected;
    subVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:subVC animated:YES completion:nil];
}
- (IBAction)isAdvancedButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    [UIView transitionWithView:self.LVLable duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom | UIViewAnimationOptionCurveEaseIn animations:^{
        self.LVLable.text = !sender.selected ? @"初级挑战" : @"高级挑战";
    } completion:nil];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [self.tipImageView expandIntoView:self.view finished:^{
        [self.tipImageView swing:^{
           [self.tipImageView removeFromSuperview];
        }];
    }];
    
}
//重写父类方法 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}
//- (void)viewWillAppear:(BOOL)animated {
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(void)dealloc {
//    NSLog(@"主视图释放");
//}
@end
