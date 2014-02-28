//
//  FileViewController.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "FileViewController.h"
#import <GLFile.h>
#import <GLGitlabApi+Files.h>
#import "CodeLoader.h"

@interface FileViewController () <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation FileViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self fetchData];
}

- (void)fetchData
{
    [[GLGitlabApi sharedInstance] getFileContentFromProject:self.project.projectId
                                                        sha:_file.fileId
                                           withSuccessBlock:^(NSData *responseData) {
                                               [self handleData:responseData];
                                               [_activityIndicator stopAnimating];
                                           }
                                            andFailureBlock:^(NSError *error) {
                                                NSLog(@"Failure: %@", error);
                                                [self showFailureMessage];
                                                [_activityIndicator stopAnimating];
                                            } ];
}


- (void)handleData:(NSData *)data
{
    if ([self isFileAnImage]) {
        [self showImage:data];
        return;
    }
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (string) {
        [self showTextResponse:string];
    }
    else {
        [self showUnsupportedFormatMessage];
    }
}

- (void)showImage:(NSData *)data {
    UIImage *image = [UIImage imageWithData:data];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.alpha = 0;
    imageView.center = self.view.center;
    
    if (!CGRectContainsRect(self.view.bounds, imageView.frame)) {
        [self scaleImageViewToFit:imageView];
    }
    
    [self.view addSubview:imageView];
    [self fadeInView:imageView];
}

- (void)scaleImageViewToFit:(UIImageView *)imageView
{
    // TODO: Actually scale the image view...
}

- (void)showTextResponse:(NSString *)string
{
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSString *htmlPath = [CodeLoader createHtmlFor:_file withContent:string];
    NSURL *url = [NSURL fileURLWithPath:htmlPath];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.alpha = 0;
    [self.view addSubview:webView];
    [self fadeInView:webView];
}

- (void)fadeInView:(UIView *)view
{
    [UIView animateWithDuration:.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         view.alpha = 1;
                     }
                     completion:nil];
}

- (void)showFailureMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"The file could not be downloaded, try again."
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (void)showUnsupportedFormatMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"The downloaded file cannot be viewed."
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"OK", nil];
    [alert show];
}

- (BOOL)isFileAnImage
{
    if ([_file.name rangeOfString:@"."].location == NSNotFound ) {
        return NO;
    }
    
    NSString *extension = [[_file.name componentsSeparatedByString:@"."] lastObject];
    NSArray *imageExtensions = @[@"tiff", @"tif", @"jpg", @"jpeg", @"gif", @"png", @"bmp", @"bmpf", @"ico", @"cur", @"xbm"];
    
    for (NSString *imageExtension in imageExtensions) {
        if ([extension caseInsensitiveCompare:imageExtension] == NSOrderedSame) {
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
