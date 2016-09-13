//
//  ViewController.m
//  自定义播放器
//
//  Created by 陈桢 on 16/4/11.
//  Copyright © 2016年 WTC. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MusicInfoDelegete.h"
#import "ListTableViewController.h"
UILabel*lable;
double angle=0;
BOOL flag;
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UISlider *progressValue;
@property AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *musicName;
@end
NSString* musicN;
NSMutableArray* imgArr1;
NSMutableArray* musicList1;
NSString*imgName1;
NSInteger musicIndex1;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //自定义进度条
    [self.progressValue setThumbImage:[UIImage imageNamed: @"thumbImg.png" ] forState:UIControlStateNormal ];
//    [self.progressValue setThumbImage:[UIImage imageNamed: @"thumbImg.png" ]  forState:UIControlStateSelected];

    
    //设置背景图片
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bgp.jpg"]];
    // 显示歌曲名
    self.musicName.text = musicN;
    self.img.image = [UIImage imageNamed:imgName1];
    //设置图片样式
    [self.img.layer setCornerRadius:CGRectGetHeight(self.img.bounds)/2];//CGRectGetHeight([self.imageView bounds])/2];
    [self.img.layer setMasksToBounds:YES];
    
    
    NSLog(@"herere");
    // 初始化slider 的值
    self.progressValue.value=_player.currentTime/_player.duration;
}

-(void)viewWillDisappear:(BOOL)animated{

    if ([_player isPlaying]) {
        [_player stop];
    }}

//实现代理
-(void)sendMusicInfo:(NSURL *)musicNameUrl musicName:(NSString*)musicName AndWith:(NSMutableArray*)imgArr AndWith:(NSString *)imgName{
    NSLog(@"%@",musicNameUrl);
    NSLog(@"name:%@",musicName);
    musicN = musicName;
    imgName1 = imgName;
    imgArr1 = imgArr;
  
    _player = [[AVAudioPlayer alloc]initWithContentsOfURL:musicNameUrl error:nil];

   NSLog(@"LLL:%@",_player);
    [_player play];
    //周期性的执行animation方法
    [NSTimer scheduledTimerWithTimeInterval: 0.1 target: self selector:@selector(animation) userInfo: nil repeats: YES];
}
-(void)sendMusicList:(NSMutableArray *)musicList index:(NSInteger)musicIndex{
    NSLog(@"list:%@",musicList);
    musicList1 = [[NSMutableArray alloc]initWithArray:musicList];
    NSLog(@"list2:%@",musicList);
    NSLog(@"index:%ld",musicIndex);
    musicIndex1 = musicIndex;
    }
//修改播放进度
- (IBAction)msivProgressChanged:(id)sender {
    //_player.currentTime = self.progressValue.value;
}
//上一曲
- (IBAction)lastMClick:(id)sender {
    [_player stop];
    if(musicIndex1==0){
        return;
    }
    musicIndex1--;
    NSString *path = [[NSBundle mainBundle]pathForResource:musicList1[musicIndex1] ofType:@"mp3"];
    self.musicName.text = musicList1[musicIndex1];
    NSLog(@"---%@%ld---%@",path,(long)musicIndex1,musicList1[musicIndex1]);
    NSURL* url = [[NSURL alloc]initFileURLWithPath:path];
    _player  = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    NSLog(@"url:%@",url);
    [_player play];
    [self.img setImage:[UIImage imageNamed:imgArr1[musicIndex1]]];
    [self.btnPlay setImage:[UIImage imageNamed:@"btnPause.png"] forState:UIControlStateNormal];
    
}
//下一曲
- (IBAction)nextMClick:(id)sender {
    
    [_player stop];
    if(musicIndex1==musicList1.count-1){
        return;
    }
    musicIndex1++;
    NSString *path = [[NSBundle mainBundle]pathForResource:musicList1[musicIndex1] ofType:@"mp3"];
    self.musicName.text = musicList1[musicIndex1];
    [self.img setImage:[UIImage imageNamed:imgArr1[musicIndex1]]];
    NSLog(@"---%@%ld---%@",path,(long)musicIndex1,musicList1[musicIndex1]);
    NSURL* url = [[NSURL alloc]initFileURLWithPath:path];
    _player  = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    NSLog(@"url:%@",url);
    [self loading];
    
    
    

}


//控制播放
- (IBAction)playState:(id)sender {
    //_player=[[AVAudioPlayer alloc]initWithContentsOfURL: error:nil];
    NSLog(@"%@",_player);
//    [_player prepareToPlay];
//    [_player play];
    [self loading];
    
}
//结束图片动画
-(void)animation
{
    self.img.transform=CGAffineTransformIdentity;
    angle = angle + 0.01;//angle角度 double angle;
    if (angle >6.27) {//大于 M_PI*2(360度)-0.01 角度再次从0开始
        angle = 0;
    }
    //  CGAffineTransform transform=CGAffineTransformRotate(self.imageView.transform, angle);
    CGAffineTransform transform=CGAffineTransformMakeRotation(angle);
    self.img.transform = transform;
    self.progressValue.value=_player.currentTime/_player.duration;
}
-(void)loading{
        //self.img.image=[UIImage imageNamed:imageName];
    if (_player.playing) {
        [_player pause];
        [self animation];
        [self.btnPlay setImage:[UIImage imageNamed:@"btnPlay.png"] forState:UIControlStateNormal];

    }else{
        [_player play];
        [self.btnPlay setImage:[UIImage imageNamed:@"btnPause.png"] forState:UIControlStateNormal];
    }
    
}

@end
