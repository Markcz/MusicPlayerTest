//
//  MusicInfoDelegete.h
//  自定义播放器
//
//  Created by 陈桢 on 16/4/26.
//  Copyright © 2016年 WTC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MusicInfoDelegate <NSObject>
//协议方法  用于视图控制器之间跳转传递参数
@required -(void)sendMusicInfo:(NSURL*)musicNameUrl musicName:(NSString*)musicName AndWith:(NSMutableArray*)imgArr AndWith:(NSString*)imgName;
@required -(void)sendMusicList:(NSMutableArray*)musicList index:(NSInteger)musicIndex;
@end

