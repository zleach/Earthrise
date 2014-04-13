//
//  ERSPageViewController.h
//  Earthrise
//
//  Created by Zach Leach on 4/12/14.
//  Copyright (c) 2014 Inkling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ERSPageViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,retain) NSURL *url;
@property (nonatomic,retain) UIWebView *pageWebView;

@end
