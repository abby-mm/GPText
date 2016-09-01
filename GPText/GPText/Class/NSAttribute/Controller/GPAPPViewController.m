//
//  GPAPPViewController.m
//  GPText
//
//  Created by dandan on 16/9/1.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPAPPViewController.h"
#import "GPTextView.h"
#import "GPToolbar.h"
#import "GPEmotionKeyboard.h"

@interface GPAPPViewController ()<UITextViewDelegate>
@property (nonatomic, weak)GPTextView *textView;
@property (nonatomic, weak)GPToolbar *toolbar;
@property (nonatomic, strong)GPEmotionKeyboard *keyboard;
@end

@implementation GPAPPViewController
#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTextView];
    [self setuipToolbar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 初始化方法
- (void)setupTextView
{
    GPTextView *textView = [[GPTextView alloc]init];
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:16];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;
}
- (void)setuipToolbar
{
    GPToolbar *toolbar = [[GPToolbar alloc]init];
    toolbar.width = SCREEN_WIDTH;
    toolbar.height = 44;
    toolbar.y = SCREEN_HEIGHT - toolbar.height;
    toolbar.btnClickBlock = ^(GPTollsBtnType type){
        [self toolBtnClick:type];
    };
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
}

#pragma mark - UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - 键盘处理
- (void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;
    }];
}
- (void)keyboardWillShow:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyboardH = keyboardF.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyboardH);
    }];
}
#pragma mark - 事件响应
- (void)toolBtnClick:(GPTollsBtnType)type
{
    switch (type) {
      
        case GPComposeToolbarButtonTypeEmotion: {
            [self openEmotion];
            break;
        }
        default:{
             [[[UIAlertView alloc] initWithTitle:@"提示" message:@"哈哈,不好意思,只能点表情哦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
            break;
        }
    }
}
- (void)openEmotion
{
    if (self.textView.inputView) {
        self.textView.inputView = nil;
        self.toolbar.showEmotionButton = YES;
    } else {
        self.textView.inputView = self.keyboard;
        self.toolbar.showEmotionButton = NO;
    }
    
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });

}

#pragma mark - set,get
-(GPEmotionKeyboard *)keyboard
{
    if (!_keyboard) {
        self.keyboard = [GPEmotionKeyboard keyboard];
        self.keyboard.backgroundColor = [UIColor blueColor];
        self.keyboard.width = SCREEN_WIDTH;
        self.keyboard.height = 220;
    }
    return _keyboard;
}
@end
