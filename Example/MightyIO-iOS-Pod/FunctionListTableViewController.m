//
//  FunctionListTableViewController.m
//  MightyIO-iOS-Pod
//
//  Created by John Bueno on 7/14/14.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "FunctionListTableViewController.h"
#import <MightyIO/Mighty.h>

@interface FunctionListTableViewController ()

@end

@implementation FunctionListTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString* functionName = cell.textLabel.text;

    switch (indexPath.row) {
    case 0:
        [[Mighty sharedInstance] getProductListWithBlock:^(NSArray* objects, NSError* error) {
            NSLog(@"OBJECTS %@", objects);
        }];
        break;

    case 1:
        NSLog(@"TEST1");
        break;

    default:
        break;
    }
}

@end
