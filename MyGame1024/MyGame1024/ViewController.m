//
//  ViewController.m
//  MyGame1024
//
//  Created by zhaimengyang on 15/12/7.
//  Copyright © 2015年 zhaimengyang. All rights reserved.
//

#import "ViewController.h"
#import "Game1024ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *startButton = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [startButton setTitle:@"start" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [startButton setBackgroundColor:[UIColor blueColor]];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
}

- (void)start{
    Game1024ViewController *game1024ViewController = [[Game1024ViewController alloc]init];
    [self presentViewController:game1024ViewController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
