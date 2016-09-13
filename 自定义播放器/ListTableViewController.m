//
//  ListTableViewController.m
//  自定义播放器
//
//  Created by 陈桢 on 16/4/26.
//  Copyright © 2016年 WTC. All rights reserved.
//

#import "ListTableViewController.h"
#import "MusicInfoDelegete.h"
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
NSArray*arrPath;
@interface ListTableViewController ()

@property NSMutableArray* musicArr;
@property NSMutableArray* imgArr;

@property (nonatomic,retain) id <MusicInfoDelegate> delegate;
@end

@implementation ListTableViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bglist.jpg"]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self initWithMusicArr];
   // NSLog(@"%@",_musicArr);
}

//初始化歌曲
-(void)initWithMusicArr{
    
        NSArray* musicA =@[@"陈奕迅-浮夸",@"单色凌,何艺纱-错位节拍",@"格子兮,牙牙乐-时间爱人",@"姜宇清-给我一支烟",@"可歆-怎么能够",@"许嵩-灰色头像",@"林俊杰-美人鱼",@"蒙面哥-一生一世好兄弟",@"梦然-北京烟火",@"梦然-没有你陪伴真的好孤单",@"少司命-摆渡",@"孙子涵-毕业后你不是我的",@"孙子涵-连借口都没有",@"孙子涵-唐人 (《唐朝好男人》电视剧主题曲)",@"夏天Alex-我依然想你",@"徐良-听妈妈的话 (Live)",@"徐良,吴昕-星座恋人",@"许嵩-星座书上",@"许嵩-有何不可",@"梦然-假如"];
        _musicArr = [[NSMutableArray alloc]init];
        for(int i = 0;i<musicA.count;i++) {
            [_musicArr addObject:[NSString stringWithFormat:@"%@",musicA[i]]];
            NSString *path = [[NSBundle mainBundle]pathForResource:_musicArr[i] ofType:@"mp3"];
            arrPath=[[NSArray alloc]initWithContentsOfFile:path];
        }
    _imgArr = [[NSMutableArray alloc]init];
    for(int i = 0;i<musicA.count;i++) {
        [_imgArr addObject:[NSString stringWithFormat:@"%d.jpg",i]];
        NSLog(@"img: %@",_imgArr);
    }
}



//实习tableView的协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _musicArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* cellID = @"cellID";
    UITableViewCell* cell =[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell  =[[UITableViewCell alloc]init];
    }
    [cell.layer setCornerRadius:5];//CGRectGetHeight([self.imageView bounds])/2];
    [cell.layer setMasksToBounds:YES];
    cell.textLabel.text=_musicArr[indexPath.row];    
    cell.imageView.image = [UIImage imageNamed: _imgArr[indexPath.row]];
    [cell.imageView.layer setCornerRadius:16];//CGRectGetHeight([self.imageView bounds])/2];
    [cell.imageView.layer setMasksToBounds:YES];
    return cell;
}
//点击跳转到下一界面
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //传递的参数
    NSString *path = [[NSBundle mainBundle]pathForResource:_musicArr[indexPath.row] ofType:@"mp3"];
    NSLog(@"Path:%@",path);
    NSURL* url = [[NSURL alloc]initFileURLWithPath:path];
    //通过Storyboard初始化播放界面的视图控制器
        ViewController* vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"viewController"];
    //使用委托代理传递参数给下一个视图控制器
    self.delegate = vc;
    if (_delegate) {
        [_delegate sendMusicInfo:url musicName:_musicArr[indexPath.row] AndWith:_imgArr AndWith:_imgArr[indexPath.row]];
        [_delegate sendMusicList:_musicArr index:indexPath.row];
    }    
    [self.navigationController pushViewController:vc animated:YES];

}
@end
