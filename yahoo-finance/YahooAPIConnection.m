//
//  YahooAPIConnection.m
//  yahoo-finance
//
//  Created by iosdev on 11.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import "YahooAPIConnection.h"
#import "AppDelegate.h"

@implementation YahooAPIConnection
@synthesize delegate;


-(void)getCurrencyExchange{
    double timeoutInterval = 30.0;
    NSString * address = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22%@%%22%%2C%%22%@%%22%%2C%%20%%22%@%%22%%2C%%20%%22%@%%22)&format=json&diagnostics=true&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=", @"USDRUB", @"USDCNY", @"USDTRY", @"USDAUD"];
    
    NSURL *url = [NSURL URLWithString:address];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                          timeoutInterval:timeoutInterval];
    NSError * error1 = [[NSError alloc] init];
    NSData * synchData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&error1];
    NSLog([[NSString alloc] initWithData:synchData encoding:NSUTF8StringEncoding]);
    
    NSError * jsonError = [[NSError alloc] init];
    NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:synchData
                                                                 options:1
                                                                   error:&jsonError];
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    NSDictionary * results = [jsonResponse valueForKeyPath:@"query.results"];
    NSMutableDictionary * dict = [results objectForKey:@"rate"];
    appDelegate.currencyExchangeArray = results;
}

@end
