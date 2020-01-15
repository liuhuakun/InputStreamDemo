//
//  AudioInputStream.m
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

#import "AudioInputStream.h"
#include "AudioDataQueue.hpp"
// 这个key值是持续写入音频data的key值
#define kReadAudioData @"ReadAudioData"

@interface AudioInputStream ()
{
    AudioDataQueue              *audioData;
}
@property (nonatomic, assign) NSStreamStatus status;
@end

@implementation AudioInputStream

@synthesize delegate;

- (instancetype)init {
    if (self = [super init]) {
        _status = NSStreamStatusNotOpen;
    }
    return self;
}

- (void)open {
    [self clearupRecording];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(bluetoothAudioDataNotification:)
                                                 name:kReadAudioData
                                               object:nil];
}

- (void)close {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:kReadAudioData
                                                  object:nil];
    @synchronized(self) {
        delete audioData;
    }
}

#pragma mark - Custom
- (BOOL)hasBytesAvailable {
    return YES;
}

- (NSStreamStatus)streamStatus {
    return self.status;
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len {
    @synchronized (self) {
        return audioData->dequeSamples(buffer, (int)len, true);
    }
}

- (BOOL)getBuffer:(uint8_t * _Nullable *)buffer length:(NSUInteger *)len {
    return NO;
}

#pragma mark method
- (void)bluetoothAudioDataNotification:(NSNotification *)notification {
    NSDictionary *dict = notification.object;
    NSData *data = dict[@"data"];
    // data转为uint8_t写入缓存队列中
    const uint8_t *cipherBuffer = (const uint8_t*)[data bytes];
    audioData->queueAudio(cipherBuffer, (int)data.length);
}

- (void)clearupRecording {
    audioData = new AudioDataQueue(16000*2*2);
    audioData->reset();
}

@end
