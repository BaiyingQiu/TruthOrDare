//
//  MainViewController.m
//  Truth or Dare
//
//  Created by Tarena on 16/6/6.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "MainViewController.h"
#import "UIView+DCAnimationKit.h"
#import "ViewController.h"


@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *TitleImageView;
@property (weak, nonatomic) IBOutlet UIButton *startButton;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}
- (IBAction)startClick:(id)sender {
    
    [self.TitleImageView drop:^{
        [self performSegueWithIdentifier:@"start" sender:nil];
    }];
    
    
}
-(void)viewWillAppear:(BOOL)animated {

    [self.TitleImageView swing:nil];
    [self.startButton expandIntoView:self.view finished:nil];
    
}
//- (BOOL)prefersStatusBarHidden{
//    return YES;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
