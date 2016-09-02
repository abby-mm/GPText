//
//  GPEmotionKeyboard.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmotionKeyboard.h"
#import "GPEmotionToolbar.h"
#import "GPEmotion.h"
#import "GPEmotionListView.h"

@interface GPEmotionKeyboard()
@property (nonatomic, weak) GPEmotionToolbar *toollbar;
@property (nonatomic, weak) GPEmotionListView *listView;
@property (nonatomic, strong) NSArray *defaultEmotions;
@property (nonatomic, strong) NSArray *emojiEmotions;
@property (nonatomic, strong) NSArray *lxhEmotions;
@end

@implementation GPEmotionKeyboard

#pragma mark - 初始化
+ (instancetype)keyboard
{
    return [[self alloc]init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self addToolbar];
        [self addListView];
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
    }
    return self;
}
- (void)addToolbar
{
    __weak typeof(self) weakSelf = self;
    GPEmotionToolbar *toollbar = [[GPEmotionToolbar alloc] init];
    [self addSubview:toollbar];
    toollbar.emtiontypeBlock = ^(GPEmtionType type){
        [weakSelf setEmtiontype:type];
    };
    self.toollbar = toollbar;
}
- (void)addListView
{
    GPEmotionListView *listView = [[GPEmotionListView alloc] init];
    [self addSubview:listView];
    self.listView = listView;
}
#pragma mark - 事件响应
- (void)setEmtiontype:(GPEmtionType)type
{
    switch (type) {
        case GPEmotionTypeRecent: {
            
            break;
        }
        case GPEmotionTypeDefault: {
            self.listView.emotions = self.defaultEmotions;
            break;
        }
        case GPEmotionTypeEmoji: {
            self.listView.emotions = self.emojiEmotions;
            break;
        }
        case GPEmotionTypeLxh: {
            self.listView.emotions = self.lxhEmotions;
            break;
        }
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.toollbar.width = self.width;
    self.toollbar.height = 35;
    self.toollbar.y = self.height - self.toollbar.height;

    self.listView.width = self.width;
    self.listView.height = self.toollbar.y;
}
#pragma mark - set,get
- (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultEmotions = [GPEmotion mj_objectArrayWithFile:plist];
        [self.defaultEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}

- (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiEmotions = [GPEmotion mj_objectArrayWithFile:plist];
        [self.emojiEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/emoji"];
    }
    return _emojiEmotions;
}

- (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhEmotions = [GPEmotion mj_objectArrayWithFile:plist];
        [self.lxhEmotions makeObjectsPerformSelector:@selector(setDirectory:) withObject:@"EmotionIcons/lxh"];
    }
    return _lxhEmotions;
}
@end
