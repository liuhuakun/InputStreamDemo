//
//  AudioInputStream.h
//  InputStreamDemo
//
//  Created by 刘华坤 on 2020/1/14.
//  Copyright © 2020 liuhuakun. All rights reserved.
//
//  READ ME
//  该自定义 InputStream 类的使用场景：
//  需要对持续写入的音频数据实时转为流的形式，确保流的获取不会中断；
//  如：百度语音识别中有音频流识别、如需要对还未写入完成【持续写入】
//  的音频数据进行实时上传识别，AudioInputStream可以帮助你实现。

#import <Foundation/Foundation.h>

@interface AudioInputStream : NSInputStream

@end
