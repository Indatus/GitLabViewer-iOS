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
                                           withSuccessBlock:^(id responseObject) {
                                               [self showTextResponse:responseObject];
                                               [_activityIndicator stopAnimating];
                                           }
                                            andFailureBlock:^(NSError *error) {
                                                NSLog(@"Failure: %@", error);
                                                [self showFailureMessage];
                                                [_activityIndicator stopAnimating];
                                            } ];
}

- (void)showTextResponse:(NSData *)data
{
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    textView.editable = NO;
    textView.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    textView.alpha = 0;
    [self.view addSubview:textView];
    
    [UIView animateWithDuration:.25
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         textView.alpha = 1;
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

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
