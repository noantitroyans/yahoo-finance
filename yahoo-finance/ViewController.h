//
//  ViewController.h
//  yahoo-finance
//
//  Created by iosdev on 11.09.14.
//  Copyright (c) 2014 ltd Elektronnie Tehnologii. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
//@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
