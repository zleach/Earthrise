//
//  ERSReaderViewController.h
//  Earthrise
//
//  Created by Zach Leach on 4/12/14.
//  Copyright (c) 2014 Inkling. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ERSPageViewController.h"

@interface ERSReaderViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate,UIGestureRecognizerDelegate> {
    NSMutableArray *pages;
    NSMutableArray *scrollers;
    NSMutableArray *pagesUrls;
}

@property (nonatomic,retain) UIScrollView *scrollView;



@end
