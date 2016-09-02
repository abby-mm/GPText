//
//  GPEmottionGridView.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPEmottionGridView.h"
#import "GPEmotion.h"
#import "GPEmotionView.h"

@interface GPEmottionGridView()
@property (nonatomic, weak) UIButton *deleteButton;

@property (nonatomic, strong) NSMutableArray *emotionViews;
@end
@implementation GPEmottionGridView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addDeletView];
    }
    return self;
}
- (void)addDeletView
{
    UIButton *deleteButton = [[UIButton alloc] init];
    [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
    [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
    [self addSubview:deleteButton];
    self.deleteButton = deleteButton;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSInteger count = emotions.count;
    NSInteger currentEmotionViewCount = self.emotionViews.count;
    for (int i = 0; i<count; i++) {
        GPEmotionView *emotionView = nil;
        
        if (i >= currentEmotionViewCount) {
            emotionView = [[GPEmotionView alloc] init];
            [self addSubview:emotionView];
            [self.emotionViews addObject:emotionView];
        } else {
            emotionView = self.emotionViews[i];
        }
        // 传递模型数据
        emotionView.emotion = emotions[i];
        emotionView.hidden = NO;
    }
    for (NSInteger i = count; i<currentEmotionViewCount; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftInset = 15;
    CGFloat topInset = 15;
    
    NSInteger count = self.emotionViews.count;
    CGFloat emotionViewW = (self.width - 2 * leftInset) / GPEmotionMaxCols;
    CGFloat emotionViewH = (self.height - topInset) / GPEmotionMaxRows;
    for (int i = 0; i<count; i++) {
        UIButton *emotionView = self.emotionViews[i];
        emotionView.x = leftInset + (i % GPEmotionMaxCols) * emotionViewW;
        emotionView.y = topInset + (i / GPEmotionMaxCols) * emotionViewH;
        emotionView.width = emotionViewW;
        emotionView.height = emotionViewH;
    }
    
    self.deleteButton.width = emotionViewW;
    self.deleteButton.height = emotionViewH;
    self.deleteButton.x = self.width - leftInset - self.deleteButton.width;
    self.deleteButton.y = self.height - self.deleteButton.height;

}
#pragma mark - set,get
- (NSMutableArray *)emotionViews
{
    if (!_emotionViews) {
        self.emotionViews = [NSMutableArray array];
    }
    return _emotionViews;
}
@end
