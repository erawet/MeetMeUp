//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Don Wettasinghe on 1/21/15.
//  Copyright (c) 2015 Don Wettasinghe. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@property (strong, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url=[NSURL URLWithString:self.urlString];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    [self.backButton setEnabled:NO];
    [self.forwardButton setEnabled:NO];
    
    
    
}


-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
    // enable / disable back and forward buttons
    self.backButton.enabled = self.webView.canGoBack;
    self.forwardButton.enabled = self.webView.canGoForward;
}

- (IBAction)onBackButtonTapped:(UIButton *)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonTapped:(UIButton *)sender {
    [self.webView goForward];
}




@end
