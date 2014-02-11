//
//  IssuesViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/5/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "IssuesViewController.h"
#import <GLGitlabApi+Issues.h>
#import "IssueCell.h"
#import "SingleIssueViewController.h"

static NSString *const kCellIdentifier = @"Cell";

@interface IssuesViewController ()
{
    NSMutableArray *_issues;
}

@end

@implementation IssuesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UINib *nib = [UINib nibWithNibName:@"IssueCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _issues.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IssueCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    GLIssue *issue = _issues[indexPath.section];
    [cell setupWithIssue:issue];
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleIssueViewController *issueVC = [SingleIssueViewController new];
    issueVC.issue = _issues[indexPath.row];
    [self.navigationController pushViewController:issueVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}

#pragma mark - Private Methods

- (void)fetchData
{
    [[GLGitlabApi sharedInstance] getAllIssuesForProjectId:self.project.projectId
                                          withSuccessBlock:^(NSArray *issues) {
                                              _issues = [issues mutableCopy];
                                              [self.tableView reloadData];
                                          }
                                           andFailureBlock:^(NSError *error) {
                                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                               message:@"Error fetching issues, please try again"
                                                                                              delegate:nil
                                                                                     cancelButtonTitle:@"OK"
                                                                                     otherButtonTitles:nil];
                                               [alert show];
                                           }];
}

@end
