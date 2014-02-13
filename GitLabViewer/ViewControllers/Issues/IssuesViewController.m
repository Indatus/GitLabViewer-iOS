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
#import "Constants.h"
#import "CreateIssueViewController.h"

static NSString *const kCellIdentifier = @"Cell";
static NSString * const kEmptyViewText = @"There are currently no\nIssues in this project.";

@interface IssuesViewController ()
{
    NSMutableArray *_issues;
    UILabel *_emptyView;
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
    
    self.title = @"Issues";
    
    UINib *nib = [UINib nibWithNibName:@"IssueCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
    [self prepareEmptyView];
    
    UIBarButtonItem *addProjectButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCreateIssueView)];
    self.navigationItem.rightBarButtonItem = addProjectButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_issues.count == 0) {
        _emptyView.hidden = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        _emptyView.hidden = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }

    return _issues.count;
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

- (void)prepareEmptyView
{
    _emptyView = [Constants emptyView];
    _emptyView.text = kEmptyViewText;
    [self.view addSubview:_emptyView];
}

- (void)showCreateIssueView
{
    UINavigationController *tempNav = [[UINavigationController alloc] initWithRootViewController:[CreateIssueViewController new]];
    [self presentViewController:tempNav animated:YES completion:nil];
}

@end
