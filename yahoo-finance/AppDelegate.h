//
//  AppDelegate.h
//  yahoo-finance
//
//  Created by iosdev on 11.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray * TempArray;

@property uint selectedTabIndex;

@end
