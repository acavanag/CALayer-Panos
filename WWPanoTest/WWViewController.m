//
//  WWViewController.m
//  WWPanoTest
//
//  Created by Andrew Cavanagh on 3/6/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "WWViewController.h"
#import "WWPanoViewer.h"

@interface WWViewController ()
@property (nonatomic, strong) WWPanoViewer *panoViewer;
@end

@implementation WWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.panoViewer = [[WWPanoViewer alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self.view addSubview:self.panoViewer];
    
}

@end
