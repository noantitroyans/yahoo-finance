//
//  ExchangeHistoryViewController.h
//  yahoo-finance
//
//  Created by iosdev on 15.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import "ViewController.h"

@interface ExchangeHistoryViewController : ViewController <UIWebViewDelegate,UIActionSheetDelegate>

@property (strong, nonatomic) NSString * selectedExchangeCC;
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end
