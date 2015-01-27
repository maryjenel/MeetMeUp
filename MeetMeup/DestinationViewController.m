//
//  DestinationViewController.m
//  MeetMeup
//
//  Created by Mary Jenel Myers on 1/19/15.
//  Copyright (c) 2015 Mary Jenel Myers. All rights reserved.
//

#import "DestinationViewController.h"

@interface DestinationViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *networkActivityIndicator;

@end

@implementation DestinationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *addressURL = [NSURL URLWithString:self.eventWeb];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressURL];
    [self.webView loadRequest:addressRequest];
    self.webView.delegate = self;
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.networkActivityIndicator startAnimating];
    self.networkActivityIndicator.hidden = false;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.networkActivityIndicator stopAnimating];
    self.networkActivityIndicator.hidden = true;
}
- (IBAction)onBackButtonPressed:(id)sender
{
    [self.webView goBack];
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender
{
    [self.webView goForward];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
