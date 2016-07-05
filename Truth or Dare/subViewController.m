//
//  subViewController.m
//  Truth or Dare
//
//  Created by Tarena on 16/5/31.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "subViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "UIView+DCAnimationKit.h"


@interface subViewController () <AVSpeechSynthesizerDelegate>

@property (nonatomic, strong)NSArray *subjects;
@property (nonatomic, assign)NSInteger subjectIndex;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, assign)SystemSoundID systemSoundID;
@property (weak, nonatomic) IBOutlet UIView *lableView;
@property (weak, nonatomic) IBOutlet UIButton *speButton;
//@property (weak, nonatomic) IBOutlet UIImageView *tapImageView;
@property(nonatomic,strong) AVSpeechSynthesizer *spe;

@end

@implementation subViewController

- (AVSpeechSynthesizer *)spe{
    if (!_spe) {
        _spe = [AVSpeechSynthesizer new];
        _spe.delegate = self;
    }
    return _spe;
}
-(NSInteger)subjectIndex {

    _subjectIndex = arc4random() % self.subjects.count;
    return _subjectIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置标题
    [self.speButton setBackgroundImage:[UIImage imageNamed:self.buttonTag == 100 ? @"title2" : @"title3"]  forState:UIControlStateNormal];
    //选择题目
    [self selecttopicWithTag:self.buttonTag andIsAdvanced:self.isAdvanced];
    //添加翻页手势
    UISwipeGestureRecognizer *swipeL = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(starSpeaking)];
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(starSpeaking)];
    swipeL.direction = UISwipeGestureRecognizerDirectionLeft;
    swipe.direction =  UISwipeGestureRecognizerDirectionUp;
    [self.textLabel addGestureRecognizer:swipe];
    [self.textLabel addGestureRecognizer:swipeL];
    self.textLabel.userInteractionEnabled = YES;
    //题目
    self.textLabel.text = self.subjects[self.subjectIndex];
    
    //
    UISwipeGestureRecognizer *swipeback = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(clickBack:)];
    swipeback.direction =  UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeback];
    
    
    //创建音效
    //AudioServicesDisposeSystemSoundID(1600);
    //创建本地音效文件（创建systemSoundID + 播放）
    self.systemSoundID = 1000;
    NSString *shortAudioPath = [[NSBundle mainBundle] pathForResource:@"kaka.wav" ofType:nil];
    NSURL *url = [NSURL fileURLWithPath:shortAudioPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef _Nonnull)(url), &_systemSoundID);//传成员的地址
    
    
}
- (void)starSpeaking {
    [UIView transitionWithView:self.lableView duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^{
        self.textLabel.text = self.subjects[self.subjectIndex];
    } completion:nil];
    
   
}
- (IBAction)clickExchangeSubject:(id)sender {

    //暂停
    if (self.spe.speaking) {
        [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        return;
    }
    //设置读取的文本
    AVSpeechUtterance *utt = [AVSpeechUtterance speechUtteranceWithString:self.textLabel.text];
    //设置使用什么语言
    utt.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh_CN"];
//    utt.rate = 0.5;
    //所有支持的语言
    //    [AVSpeechSynthesisVoice speechVoices]
    //播放
    [self.spe speakUtterance:utt];

    

    
}
//nextIndex

- (IBAction)clickBack:(id)sender {
    if (self.spe.speaking) {
        [self.spe stopSpeakingAtBoundary:AVSpeechBoundaryWord];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selecttopicWithTag:(NSInteger )tag andIsAdvanced:(BOOL )isAdvanced{
    NSString *plistPath = nil;
    
    if (isAdvanced == NO) {
        //普通
        if (tag == 100) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"T1.plist" ofType:nil];
        } else {
            plistPath = [[NSBundle mainBundle] pathForResource:@"d1.plist" ofType:nil];
        }
    } else {
        //高级
        if (tag == 101) {
            plistPath = [[NSBundle mainBundle] pathForResource:@"d2.plist" ofType:nil];
        } else {
            plistPath = [[NSBundle mainBundle] pathForResource:@"T2.plist" ofType:nil];
        }
    }
    self.subjects = [NSArray arrayWithContentsOfFile:plistPath];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //震动
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    //播放
    AudioServicesPlaySystemSound(_systemSoundID);
    
    
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {

}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {

//    [UIView transitionWithView:self.lableView duration:0.3 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionTransitionFlipFromLeft  animations:^{
//        self.textLabel.text = self.subjects[self.subjectIndex];
//    } completion:nil];
//    [self.lableView bounce:^{
//        self.textLabel.text = self.subjects[self.subjectIndex];
//    }];
    [self.lableView shake:^{
        self.textLabel.text = self.subjects[self.subjectIndex];
    }];
    

}
//重写父类方法 隐藏状态栏
-(BOOL)prefersStatusBarHidden{
    return YES;
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
