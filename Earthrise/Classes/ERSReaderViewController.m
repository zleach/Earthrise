//
//  ERSReaderViewController.m
//  Earthrise
//
//  Created by Zach Leach on 4/12/14.
//  Copyright (c) 2014 Inkling. All rights reserved.
//

#import "ERSReaderViewController.h"
#import "ERSPageViewController.h"

@interface ERSReaderViewController ()

@end

@implementation ERSReaderViewController

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
    
    
    // Scrollview
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    
    pagesUrls = [[NSMutableArray alloc] initWithObjects:
                      @"http://www.w3schools.com/html/html_examples.asp",
                 @"http://www.w3schools.com/html/html_colors.asp",
                 @"http://www.w3schools.com/html/html_examples.asp",
                      nil];

    pages = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < pagesUrls.count; i++) {
        NSURL *url = [NSURL URLWithString:pagesUrls[i]];
        
        UIScrollView *pageScroller = [[UIScrollView alloc] initWithFrame:CGRectZero];
        pageScroller.tag = i;
        pageScroller.contentSize = CGSizeMake(self.view.frame.size.width, CGFLOAT_MIN);
        
        UIWebView *pageWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [pageWebView loadRequest:[NSURLRequest requestWithURL:url]];
        pageWebView.delegate = self;
        pageWebView.scrollView.delegate = self;
        pageWebView.scrollView.scrollEnabled = NO;
        pageWebView.scalesPageToFit = YES;
        pageWebView.tag = i;
        
        [pages addObject:pageScroller];
        [pageScroller addSubview:pageWebView];
        
        [self.scrollView addSubview:pageScroller];
    }
    
    [self layoutPages];
    [self addGestureRecognizers];
    
}

- (void)layoutPages {
    int index = 0;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    
    
    for (UIScrollView *pageScroller in pages) {
        CGFloat pageXOffset = index*width;
        pageScroller.frame = CGRectMake(pageXOffset, 0, width, height);
        index ++;
    }
    
    // Scrollview
    self.scrollView.contentSize = CGSizeMake(pages.count*width,CGFLOAT_MIN);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) addGestureRecognizers{
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    pinchRecognizer.delegate = self;

    [self.view addGestureRecognizer:pinchRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void) pinch:(UIPinchGestureRecognizer *)recognizer{
    
    CGFloat scale =
    [(UIPinchGestureRecognizer *)recognizer scale];

    CGFloat velocity =
    [(UIPinchGestureRecognizer *)recognizer velocity];
    
    NSString *resultString = [[NSString alloc] initWithFormat:
                              @"Pinch - scale = %f, velocity = %f",
                              scale, velocity];
    NSLog(@"%@",resultString);
    
    [self enterOverview];
}


- (void) enterOverview {
    for (UIScrollView *pageScroller in pages) {
        pageScroller.transform = CGAffineTransformScale(CGAffineTransformIdentity, .5, .5);
        
    }
    
}


#pragma mark -
#pragma mark UIWebViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return nil;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.height"] floatValue];
    CGRect frame = webView.frame;
    frame.size.height = height;
    webView.frame = frame;

    UIScrollView *pageScroller = [pages objectAtIndex:webView.tag];
    
    pageScroller.contentSize = CGSizeMake(self.view.frame.size.width, height);
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [webView loadHTMLString:errorString baseURL:nil];
}


@end
