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

    [[Mighty sharedInstance] makeRibbonWithFrame:CGRectMake(20, 20, 100, 200) inViewController:self withIntroModalOnFirstLaunch:YES];
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
