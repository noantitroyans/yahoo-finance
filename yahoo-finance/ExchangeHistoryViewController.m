//
//  ExchangeHistoryViewController.m
//  yahoo-finance
//
//  Created by iosdev on 15.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import "ExchangeHistoryViewController.h"

@interface ExchangeHistoryViewController (){
    UIViewController * modalViewController;
}

@end

@implementation ExchangeHistoryViewController
@synthesize selectedExchangeCC = _selectedExchangeCC, webView = _webView;

-(void)viewWillAppear:(BOOL)animated{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_webView setScalesPageToFit:YES];
    
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Выберите интервал:" delegate:self cancelButtonTitle:@"Отмена" destructiveButtonTitle:nil otherButtonTitles:
                            @"5 дней",
                            @"10 дней",
                            @"15 дней",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == actionSheet.cancelButtonIndex){
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    uint dayCount = 0;
    switch (actionSheet.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    dayCount = 5;
                    break;
                case 1:
                    dayCount = 10;
                    break;
                case 2:
                    dayCount = 15;
                    break;
                    
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    
    NSURL *url = [NSURL URLWithString: [NSString stringWithFormat:@"http://chart.finance.yahoo.com/z?s=%@=X&t=%dd&q=l&z=m", _selectedExchangeCC, dayCount]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

@end
