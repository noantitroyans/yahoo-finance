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

@interface ViewController ()
{
    AppDelegate * appDelegate;
    
}

@end

@implementation ViewController
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    appDelegate = [[UIApplication sharedApplication] delegate];
    
    [self performSelectorInBackground:@selector(getCurrencyExchangeData) withObject:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) getCurrencyExchangeData{
    YahooAPIConnection * connection = [[YahooAPIConnection alloc] init];
    [connection getCurrencyExchange];
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
    return appDelegate.currencyExchangeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"currencyCell"];
    currencyTableViewCell * currencyCell = (currencyTableViewCell*)cell;
    NSDictionary * currentJSONResult = appDelegate.currencyExchangeArray ? [appDelegate.currencyExchangeArray objectForKey:@"USDRUB"] : nil;
    currencyCell.nameLabel.text = [NSString stringWithFormat:@"row %d", indexPath.row];
    currencyCell.valueLabel.text = @"100500";
    return cell;
}


@end
