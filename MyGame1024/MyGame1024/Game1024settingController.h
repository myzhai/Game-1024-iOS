//
//  Game1024settingController.h
//  SinaWeiBo
//
//  Created by zhaimengyang on 15/10/17.
//  Copyright (c) 2015年 zhaimengyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Game1024settingController;
@protocol Game1024settingControllerDelegate <NSObject>

- (void)game1024settingController:(Game1024settingController *)Game1024settingController settingsDone:(NSDictionary *)settings;

@end

@interface Game1024settingController : UIViewController

@property(nonatomic, weak) id<Game1024settingControllerDelegate> delegate;

@end
