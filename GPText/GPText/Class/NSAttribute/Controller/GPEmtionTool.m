//
//  GPEmtionTool.m
//  GPText
//
//  Created by dandan on 16/9/5.
//  Copyright © 2016年 dandan. All rights reserved.
//

#define GPRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]

#import "GPEmtionTool.h"
#import "GPEmotion.h"
#import <MJExtension.h>

static NSArray *_defaultEmotions;
static NSArray *_emojiEmotions;
static NSArray *_lxhEmotions;
static NSMutableArray *_recentEmotions;


@implementation GPEmtionTool
+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [GPEmotion mj_objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

+ (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiEmotions = [GPEmotion mj_objectArrayWithFile:plist];
        [_emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}

+ (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhEmotions = [GPEmotion mj_objectArrayWithFile:plist];
        [_lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}

+ (NSArray *)recentEmotions
{
    if (!_recentEmotions) {
        _recentEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:GPRecentFilepath];
        if (!_recentEmotions) {
            _recentEmotions = [NSMutableArray array];
        }
    }
    return _recentEmotions;
}

+ (void)addRecentEmotion:(GPEmotion *)emotion
{
 
    [self recentEmotions];
    
    [_recentEmotions removeObject:emotion];
    
    [_recentEmotions insertObject:emotion atIndex:0];
    
    [NSKeyedArchiver archiveRootObject:_recentEmotions toFile:GPRecentFilepath];
}
@end
