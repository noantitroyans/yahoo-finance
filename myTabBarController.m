//
//  myTabBarController.m
//  yahoo-finance
//
//  Created by iosdev on 15.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import "myTabBarController.h"
#import "AppDelegate.h"

@interface myTabBarController ()

@end

@implementation myTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.selectedTabIndex = item.tag;
}



@end
