//
//  ViewController.m
//  yahoo-finance
//
//  Created by iosdev on 11.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import "ViewController.h"
#import "currencyTableViewCell.h"
#import "YahooAPIConnection.h"
#import "AppDelegate.h"
#import "CurrencyExchangeClass.h"
#import "ExchangeHistoryViewController.h"

@interface ViewController ()
{
    AppDelegate * appDelegate;
    NSDate * lastUpdateTime;
    UIRefreshControl * refreshControl;
    NSMutableArray * valuesArray;
}

@end

@implementation ViewController
@synthesize tableView = _tableView;

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!lastUpdateTime || ABS([lastUpdateTime timeIntervalSinceNow])>60 ) {
        [self updateContent];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(updateContent) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) updateContent{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self performSelectorInBackground:@selector(getCurrencyExchange_InBackground) withObject:nil];
}

-(void) getCurrencyExchange_InBackground{
    YahooAPIConnection * connection = [[YahooAPIConnection alloc] init];
    [connection getCurrencyExchange];
    [self performSelectorOnMainThread:@selector(gotCurrencyExchangeData_OnMainThread) withObject:nil waitUntilDone:NO];
}

-(void) gotCurrencyExchangeData_OnMainThread{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    lastUpdateTime = [NSDate date];
    valuesArray = appDelegate.TempArray.mutableCopy;
    appDelegate.TempArray = nil;
    [self performSelectorOnMainThread:@selector(reloadTableView) withObject:nil waitUntilDone:NO];
}

-(void) reloadTableView{
    [_tableView reloadData];
}


#pragma mark - Table View Delegate:

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return valuesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"currencyCell"];
    currencyTableViewCell * currencyCell = (currencyTableViewCell*)cell;
    CurrencyExchangeClass * currentExchangeValues = [valuesArray objectAtIndex:indexPath.row];
    currencyCell.nameLabel.text = currentExchangeValues.name;
    currencyCell.valueLabel.text = currentExchangeValues.rate;
    
    @try {
        NSString * countryCode = [[currentExchangeValues.name componentsSeparatedByString:@" "] lastObject];
        [currencyCell.imageView setImage:[UIImage imageNamed:countryCode]];
    }
    @catch (NSException *exception) {
        NSLog(exception.description);
    }
    @finally {
        
    }
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    ExchangeHistoryViewController * destinationVC = [segue destinationViewController];
    currencyTableViewCell * currencyCell = (currencyTableViewCell*)sender;
    
    @try {
        destinationVC.selectedExchangeCC = [[[currencyCell.nameLabel.text componentsSeparatedByString:@" "] firstObject]
                                            stringByAppendingString: [[currencyCell.nameLabel.text componentsSeparatedByString:@" "] lastObject]];
    }
    @catch (NSException *exception) {
        NSLog(exception.description);
    }
    
}


@end
