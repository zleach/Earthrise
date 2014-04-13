//
//  ERSPageViewController.m
//  Earthrise
//
//  Created by Zach Leach on 4/12/14.
//  Copyright (c) 2014 Inkling. All rights reserved.
//

#import "ERSPageViewController.h"

@interface ERSPageViewController ()

@end

@implementation ERSPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.pageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(10, 20, 300,500)];
    self.pageWebView.backgroundColor = [UIColor whiteColor];
    self.pageWebView.scalesPageToFit = YES;
    self.pageWebView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    [self.pageWebView loadRequest:[NSURLRequest requestWithURL:self.url]];
    [self.view addSubview:self.pageWebView];
}

@end
