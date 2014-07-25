//
//  smViewController.m
//  MightyIO-iOS-Pod
//
//  Created by Gavin Potts on 07/09/2014.
//  Copyright (c) 2014 Gavin Potts. All rights reserved.
//

#import "smViewController.h"
#import <MightyIO-iOS-Pod/Mighty.h>

@interface smViewController ()

@end

@implementation smViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"View Did Load");
    [[Mighty sharedInstance] makeRibbonWithCenter:CGPointMake(260, 95) inViewController:self];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startSupermighty:(id)sender
{
    //[[Mighty sharedInstance] startSuperMightyInViewController:self];
}
@end
