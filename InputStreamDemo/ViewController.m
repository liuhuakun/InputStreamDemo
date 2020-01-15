//
//  ViewController.m
//  InputStreamDemo
//
//  Created by 刘华坤 on 2020/1/14.
//  Copyright © 2020 liuhuakun. All rights reserved.
//

#import "ViewController.h"
#import "AudioInputStream.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 使用：
    // 当AudioInputStream.mm中的open方法的监听通知 kReadAudioData 有音频数据时
    // inputStream就是需要获取的输入流
    AudioInputStream *inputStream = [[AudioInputStream alloc] init];
}

@end
