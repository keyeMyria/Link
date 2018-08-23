//
//  FbWebView.m
//  Runner
//
//  Created by Brett on 8/21/18.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

#import "FbWebView.h"
#import <WebKit/WebKit.h>


@interface FbWebView ()


@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) UIView *bottomNavBar;
@property (strong, nonatomic)  UIButton *fwdBtn;
@property (strong, nonatomic)  UIButton *backBtn;
@property (strong, nonatomic)  UIButton *closeBtn;
@property (strong, nonatomic)  UIProgressView *progressBar;
@property (strong, nonatomic)  NSTimer *progressTimer;
@property ( nonatomic)  bool finishedLoading;



@end

@implementation FbWebView


- (instancetype)initWithURL:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addWeb];
    [self addNav]; // s/o to nav
    [self setupLoadingBar];
    
}


-(void)setupLoadingBar{
    self.progressBar = [[UIProgressView alloc]initWithFrame:CGRectMake(0.0, 50.0, self.view.frame.size.width, 50.0)];
    self.progressBar.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_progressBar];
    _progressTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];

}

- (void)addWeb{
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.0, 50.0, self.view.frame.size.width, (self.view.frame.size.height - 100.0)) configuration:theConfiguration];
    NSURL *nsurl=[NSURL URLWithString:_url];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_webView loadRequest:nsrequest];

    [self.view addSubview:_webView];
}

- (void) addNav{
    _bottomNavBar = [[UIView alloc]initWithFrame:CGRectMake(0.0, (self.webView.frame.size.height - 70.0), self.webView.frame.size.width, 70.0)];
    [_bottomNavBar setUserInteractionEnabled:true];
    _bottomNavBar.backgroundColor = [[UIColor yellowColor] colorWithAlphaComponent:0.5f];
    [_webView addSubview:_bottomNavBar];
    
    _fwdBtn = [[UIButton alloc]initWithFrame:CGRectMake(70.0,5.0 , 50.0, 50.0)];
    [_fwdBtn setImage:[UIImage imageNamed:@"forwardArrow"] forState:UIControlStateNormal];
    [_fwdBtn addTarget:self action:@selector(goFwd) forControlEvents:UIControlEventTouchUpInside];

    _backBtn = [[UIButton alloc]initWithFrame:CGRectMake(10,5.0, 50.0, 50.0)];
    [_backBtn setImage:[UIImage imageNamed:@"backArrow"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    
    _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake((self.view.frame.size.width - 70.0),5.0 , 50.0, 50.0)];
    [_closeBtn setImage:[UIImage imageNamed:@"closeBlack"] forState:UIControlStateNormal];
    [_closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];


    [_bottomNavBar addSubview:_backBtn];
    [_bottomNavBar addSubview:_fwdBtn];
    [_bottomNavBar addSubview:_closeBtn];

}

-(void) goBack{
    [_webView goBack];
}
-(void) goFwd{
    [_webView goForward];
}
-(void) close{
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)timerCallback {
    
    if(_progressBar.progress >= 1.0){
        [_progressTimer invalidate];
        [_progressBar removeFromSuperview];
        return;
    }


            _progressBar.progress = self.webView.estimatedProgress;
   

}



@end
