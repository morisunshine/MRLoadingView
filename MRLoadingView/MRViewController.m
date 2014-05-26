//
//  MRViewController.m
//  MRLoadingView
//
//  Created by Sheldon on 14-5-25.
//  Copyright (c) 2014年 Sheldon. All rights reserved.
//

#import "MRViewController.h"
#import "MRLoadingView.h"

@interface MRViewController ()

@end

@implementation MRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect rect = self.view.bounds;
    MRLoadingView *loadingView = [[MRLoadingView alloc] initWithFrame:CGRectMake(CGRectGetWidth(rect) / 2 - 50, CGRectGetHeight(rect) / 2 - 50, 100, 100)];
    [self.view addSubview:loadingView];
    [loadingView startLoading];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
