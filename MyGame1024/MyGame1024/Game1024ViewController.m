//
//  Game1024ViewController.m
//  SinaWeiBo
//
//  Created by zhaimengyang on 15/10/15.
//  Copyright (c) 2015年 zhaimengyang. All rights reserved.
//

#import "Game1024ViewController.h"
#import "Game1024View.h"
#import "LogicIn1024.h"
#import "Game1024settingController.h"
#import "UIView+Extension.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height


@interface Game1024ViewController ()<UIAlertViewDelegate, Game1024settingControllerDelegate>

@property(nonatomic, weak) Game1024View *game1024View;
@property(nonatomic, strong) NSMutableArray *numbers;
@property(nonatomic, assign) NSInteger swipeDirection;

@property(nonatomic, assign) NSInteger numberOfProvided;
@property(nonatomic, assign) NSInteger toStart;

@end

@implementation Game1024ViewController

- (NSMutableArray *)numbers{
    if (!_numbers) {
        _numbers = [NSMutableArray array];
    }
    
    return _numbers;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self addSettingButton];
    [self addGame1024View];
    [self addSwipeGesture];
    
    self.toStart = 0;
    self.numberOfProvided = 0;
    [self start];
}

- (void)start{
    int nums[X][Y] = {0};
    start((int *)nums, self.toStart == 0 ? 6 : (int)self.toStart);
    
    int *cp = showMap(nums);
    [self showNumbers:cp];
    free(cp);
}

- (void)showNumbers:(int *)cp{
    [self.numbers removeAllObjects];
    
    for (int i = 0; i < 16; i++) {
        [self.numbers addObject:@(*(cp+i))];
    }
    
    self.game1024View.numbers = self.numbers;
}

- (void)addSettingButton{
    for (int i = 0; i < 2; i++) {
        UIButton *button = [[UIButton alloc]init];
        button.backgroundColor = [UIColor redColor];
        if (i == 0) {
            [button setTitle:@"难度设置" forState:UIControlStateNormal];
            [button sizeToFit];
            button.centerX = SCREEN_WIDTH * 0.5;
            [button addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button setTitle:@"不玩了" forState:UIControlStateNormal];
            [button sizeToFit];
            button.x = 30;
            [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
        }
        button.centerY = 50;
        [self.view addSubview:button];
    }
}

- (void)addGame1024View{
    CGFloat game1024ViewX = 0;
    CGFloat game1024ViewY = 100;
    CGFloat game1024ViewW = [UIScreen mainScreen].bounds.size.width;
    CGFloat game1024ViewH = [UIScreen mainScreen].bounds.size.height;
    Game1024View *game1024View = [[Game1024View alloc]initWithFrame:CGRectMake(game1024ViewX, game1024ViewY, game1024ViewW, game1024ViewH)];
    [self.view addSubview:game1024View];
    self.game1024View = game1024View;
}

- (void)addSwipeGesture{
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUp];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDown];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipe:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeRight];
}

- (void)swipe:(UISwipeGestureRecognizer *)recognizer{
    self.swipeDirection = recognizer.direction;
    
    int nums[X][Y] = {0};
    for (int i = 0; i < X; i++) {
        for (int j = 0; j < Y; j++) {
            nums[i][j] = [self getFrequency:(int)[self.numbers[i * 4 + j] integerValue]];
        }
    }
    
    inPut(nums, (int)self.swipeDirection);
    
    int *cp = showMap(nums);
    [self showNumbers:cp];
    free(cp);
    
    if (provNums((int *)nums, self.numberOfProvided == 0 ? 2 : (int)self.numberOfProvided)) {
        int *cp = showMap(nums);
        [self showNumbers:cp];
        free(cp);
    } else {
        if (isDied(nums) == 0){
            NSLog(@"完蛋");
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"你娃挂了" delegate:nil cancelButtonTitle:@"这智商哎好吧" otherButtonTitles:nil];
            alter.delegate = self;
            [alter show];
        }
    }
}

- (int)getFrequency:(int)num{
    int count = 0;
    while ((num /= 2) > 0) {
        count++;
    }
    
    return count;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self start];
}

- (void)settings{
    Game1024settingController *settingController = [[Game1024settingController alloc]init];
    settingController.delegate = self;
    [self presentViewController:settingController animated:YES completion:nil];
}

- (void)goBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)game1024settingController:(Game1024settingController *)Game1024settingController settingsDone:(NSDictionary *)settings{
    /*********************************************************
     * dict[@"numberOfProvided"] = @(self.numberOfProvided); *
     * dict[@"toStart"] = @(self.toStart);                   *
     *********************************************************/
    NSInteger numberOfProvided = [settings[@"numberOfProvided"] integerValue];
    NSInteger toStart = [settings[@"toStart"] integerValue];
    if (self.numberOfProvided != numberOfProvided || self.toStart != toStart) {
        self.numberOfProvided = numberOfProvided;
        self.toStart = toStart;
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:nil message:@"设置已经更改" delegate:nil cancelButtonTitle:@"重新开始" otherButtonTitles:nil];
        alter.delegate = self;
        [alter show];
    }
}

@end