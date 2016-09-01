//
//  Game1024settingController.m
//  SinaWeiBo
//
//  Created by zhaimengyang on 15/10/17.
//  Copyright (c) 2015年 zhaimengyang. All rights reserved.
//

#import "Game1024settingController.h"
#import "LIVBubbleMenu.h"
#import "UIView+Extension.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


typedef NS_ENUM(NSUInteger, SettingButtonType) {
    SettingButtonTypeNumberOfProvided = 100,
    SettingButtonTypeToStart,
};

@interface Game1024settingController ()<LIVBubbleButtonDelegate>

@property(nonatomic, strong) NSArray *images;
@property(nonatomic, strong) LIVBubbleMenu *bubbleMenu;

@property(nonatomic, assign) NSInteger numberOfProvided;
@property(nonatomic, assign) NSInteger toStart;

@end

@implementation Game1024settingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addSettingButton];
    
    self.images = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"sad"],
                   [UIImage imageNamed:@"neutral"],
                   [UIImage imageNamed:@"happy"],
                   [UIImage imageNamed:@"cool"],
               nil];
    self.numberOfProvided = 0;
    self.toStart = 0;
}

- (void)addSettingButton{
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.backgroundColor = [UIColor redColor];
        if (i == 0) {
            [button setTitle:@"每次新出几个数字" forState:UIControlStateNormal];
            button.tag = SettingButtonTypeNumberOfProvided;
            [button addTarget:self action:@selector(numberOfProvidedNumbers:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button setTitle:@"初始化的数字个数" forState:UIControlStateNormal];
            button.tag = SettingButtonTypeToStart;
            [button addTarget:self action:@selector(numberOfNumbersToStart:) forControlEvents:UIControlEventTouchUpInside];
        }
        [button sizeToFit];
        button.centerX = SCREEN_WIDTH * 0.5;
        button.centerY = SCREEN_HEIGHT * 0.5 + (i == 0 ? -150 : 150);
        [self.view addSubview:button];
    }
    
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.backgroundColor = [UIColor blueColor];
        if (i == 0) {
            [button setTitle:@"取消" forState:UIControlStateNormal];
            [button sizeToFit];
            [button addTarget:self action:@selector(cancelButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
            button.x = 30;
        } else {
            [button setTitle:@"完成" forState:UIControlStateNormal];
            [button sizeToFit];
            [button addTarget:self action:@selector(doneButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
            button.x = SCREEN_WIDTH - 30 - button.width;
        }
        button.y = 60;
        [self.view addSubview:button];
    }
}

#pragma mark - Private Methods
- (void)cancelButtonDidClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doneButtonDidClick{
    if (self.delegate) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"numberOfProvided"] = @(self.numberOfProvided);
        dict[@"toStart"] = @(self.toStart);
        [self.delegate game1024settingController:self settingsDone:dict];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)numberOfProvidedNumbers:(UIButton *)button{
    self.bubbleMenu = [[LIVBubbleMenu alloc] initWithPoint:button.center radius:150 menuItems:[NSArray arrayWithObjects:self.images.firstObject, self.images.lastObject, nil] inView:self.view];
    self.bubbleMenu.delegate = self;
    self.bubbleMenu.easyButtons = NO;
    self.bubbleMenu.bubbleStartAngle = 0.0f;
    self.bubbleMenu.bubbleTotalAngle = 180.0f;
    self.bubbleMenu.tag = button.tag;
    [self.bubbleMenu show];
}

- (void)numberOfNumbersToStart:(UIButton *)button{
    self.bubbleMenu = [[LIVBubbleMenu alloc] initWithPoint:button.center radius:150 menuItems:self.images inView:self.view];
    self.bubbleMenu.delegate = self;
    self.bubbleMenu.easyButtons = NO;
    self.bubbleMenu.bubbleStartAngle = 180.0f;
    self.bubbleMenu.bubbleTotalAngle = 180.0f;
    self.bubbleMenu.tag = button.tag;
    [self.bubbleMenu show];
}

#pragma mark - Delegate Methods
-(void)livBubbleMenu:(LIVBubbleMenu *)bubbleMenu tappedBubbleWithIndex:(NSUInteger)index {
    NSLog(@"User has selected bubble index: %tu", index);
    NSLog(@"bubbleMenu.tag = %ld",(long)bubbleMenu.tag);
    /********************************************
     *  SettingButtonTypeNumberOfProvided = 100 *
     *  SettingButtonTypeToStart                *
     ********************************************/
    switch (bubbleMenu.tag) {
        case SettingButtonTypeNumberOfProvided://index = 0, 1 --->> provided = 1, 2
            self.numberOfProvided = index + 1;
            break;
            
        case SettingButtonTypeToStart://index = 0, 1, 2, 3 --->> toStart = 5, 6, 7, 8
            self.toStart = index + 5;
            break;
            
        default:
            break;
    }
}

-(void)livBubbleMenuDidHide:(LIVBubbleMenu *)bubbleMenu {
    NSLog(@"LIVBubbleMenu has been hidden");
}

@end
