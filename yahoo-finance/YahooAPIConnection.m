//
//  YahooAPIConnection.m
//  yahoo-finance
//
//  Created by iosdev on 11.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import "YahooAPIConnection.h"
#import "AppDelegate.h"
#import "CurrencyExchangeClass.h"
#import "AppDelegate.h"

@implementation YahooAPIConnection{
    NSMutableArray * exchangeParametersArray;
}
@synthesize delegate;


-(void)getCurrencyExchange{
    [self setExchangeParameters];
    double timeoutInterval = 30.0;
    
    NSString * address = [NSString stringWithFormat:@"https://query.yahooapis.com/v1/public/yql?q=select%%20*%%20from%%20yahoo.finance.xchange%%20where%%20pair%%20in%%20(%%22%@%%22%%2C%%22%@%%22%%2C%%20%%22%@%%22%%2C%%20%%22%@%%22)&format=json&diagnostics=true&env=store%%3A%%2F%%2Fdatatables.org%%2Falltableswithkeys&callback=",
                          [exchangeParametersArray objectAtIndex:0],
                          [exchangeParametersArray objectAtIndex:1],
                          [exchangeParametersArray objectAtIndex:2],
                          [exchangeParametersArray objectAtIndex:3]];
    
    NSURL *url = [NSURL URLWithString:address];
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url
                                                              cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                          timeoutInterval:timeoutInterval];
    NSError * error1 = [[NSError alloc] init];
    NSData * synchData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:nil error:&error1];
//    NSLog([[NSString alloc] initWithData:synchData encoding:NSUTF8StringEncoding]);
    if (error1.code > 0) {
        UIAlertView * alertView = [[UIAlertView new] initWithTitle:@"Ошибка" message:@"Не удалось получить данные"
                                                      delegate:self cancelButtonTitle:nil otherButtonTitles:@"ОК", nil];
        [alertView show];
        return;
    }
    
    NSError * JSONError = [[NSError alloc] init];
    NSDictionary *JSONResponse = [NSJSONSerialization JSONObjectWithData:synchData
                                                                 options:kNilOptions
                                                                   error:&JSONError];
    if (JSONError.code > 0) {
        UIAlertView * alertView = [[UIAlertView new] initWithTitle:@"Ошибка" message:@"Неверный формат данных"
                                                          delegate:self cancelButtonTitle:nil otherButtonTitles:@"ОК", nil];
        [alertView show];
        return;
    }
    
    NSMutableArray * JSONResultsArray = [[JSONResponse valueForKeyPath:@"query.results.rate"] mutableCopy];
    NSMutableArray * currencyExchangeResultsArray = [NSMutableArray new];
    for (NSMutableDictionary * currentResult in JSONResultsArray) {
        CurrencyExchangeClass * currencyExchange = [[CurrencyExchangeClass alloc] init];
        currencyExchange.name = [currentResult valueForKey:@"Name"];
        currencyExchange.rate = [currentResult valueForKey:@"Rate"];
        [currencyExchangeResultsArray addObject:currencyExchange];
    }
    
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.TempArray = currencyExchangeResultsArray;
}

-(void)setExchangeParameters{
    AppDelegate * appDelegate = [[UIApplication sharedApplication] delegate];
    exchangeParametersArray = [NSMutableArray new];
    
    switch (appDelegate.selectedTabIndex) {
        case 0: // USD
        {
            [exchangeParametersArray addObject:@"USDRUB"];
            [exchangeParametersArray addObject:@"USDCNY"];
            [exchangeParametersArray addObject:@"USDTRY"];
            [exchangeParametersArray addObject:@"USDAUD"];
        }
            break;
            
        case 1: // RUB
        {
            [exchangeParametersArray addObject:@"RUBUSD"];
            [exchangeParametersArray addObject:@"RUBCNY"];
            [exchangeParametersArray addObject:@"RUBTRY"];
            [exchangeParametersArray addObject:@"RUBAUD"];
        }
            break;
            
        case 2: // CNY
        {
            [exchangeParametersArray addObject:@"CNYRUB"];
            [exchangeParametersArray addObject:@"CNYUSD"];
            [exchangeParametersArray addObject:@"CNYTRY"];
            [exchangeParametersArray addObject:@"CNYAUD"];
        }
            break;
            
        case 3: // TRY
        {
            [exchangeParametersArray addObject:@"TRYRUB"];
            [exchangeParametersArray addObject:@"TRYCNY"];
            [exchangeParametersArray addObject:@"TRYUSD"];
            [exchangeParametersArray addObject:@"TRYAUD"];
        }
            break;
            
            
        default:
            break;
    }
}

@end
