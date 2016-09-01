//
//  Game1024View.m
//  SinaWeiBo
//
//  Created by zhaimengyang on 15/10/15.
//  Copyright (c) 2015年 zhaimengyang. All rights reserved.
//

#import "Game1024View.h"
#import "UIView+Extension.h"

@interface Game1024View ()

@property(nonatomic, strong) NSMutableArray *rects;

@end

@implementation Game1024View

- (NSMutableArray *)rects{
    if (!_rects) {
        _rects = [NSMutableArray array];
    }
    
    return _rects;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self addRects];
    }
    
    return self;
}

- (void)layoutSubviews{
    CGFloat offsetY = 90;
    CGFloat margin = 10;
    CGFloat width = (self.width - 5 * margin) / 4;
    CGFloat height = width;
    CGSize size = CGSizeMake(width, height);
    NSInteger col = 0;
    NSInteger row = 0;
    
    for (int i = 0; i < 16; i++) {
        col = i % 4;
        row = i / 4;
        UILabel *label = self.rects[i];
        label.size = size;
        label.x = (width + margin) * col + margin;
        label.y = (height + margin) * row + margin + offsetY;
    }
}

- (void)addRects{
    for (int i = 0; i < 16; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor greenColor];
        label.font = [UIFont systemFontOfSize:20];
        [self.rects addObject:label];
        [self addSubview:label];
    }
}

- (void)setNumbers:(NSMutableArray *)numbers{
    _numbers = numbers;
    
    for (int i = 0; i < self.rects.count; i++) {
        UILabel *label = self.rects[i];
        label.text = [NSString stringWithFormat:@"%@",numbers[i]];
        if ([label.text isEqualToString:@"0"]) {
            label.text = nil;
        }
    }
}

@end
