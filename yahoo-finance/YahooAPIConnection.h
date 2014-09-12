//
//  YahooAPIConnection.h
//  yahoo-finance
//
//  Created by iosdev on 11.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YahooAPIDelegate <NSObject>
@end

@interface YahooAPIConnection : NSObject <NSURLConnectionDelegate>
@property (nonatomic) id <YahooAPIDelegate> delegate;

- (void)getCurrencyExchange;

@end