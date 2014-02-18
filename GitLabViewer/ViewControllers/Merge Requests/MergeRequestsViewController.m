//
//  MergeRequestsViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/5/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "MergeRequestsViewController.h"
#import "Constants.h"
#import "GLNavigationController.h"
#import "CreateMergeRequestViewController.h"
#import "SingleMergeRequestViewController.h"
#import "MergeRequestCell.h"

static NSString * const kCellIdentifier = @"Cell";
static NSString * const kEmptyViewText = @"There are currently no\nMerge Requests in this project.";

@interface MergeRequestsViewController ()
{
    NSMutableArray *_mergeRequests;
    UILabel *_emptyView;
}

@end

@implementation MergeRequestsViewController

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
    UINib *nib = [UINib nibWithNibName:@"MergeRequestCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];
    
    self.title = @"Merge Requests";
    [self prepareEmptyView];
    
    UIBarButtonItem *addProjectButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showCreateMergeRequestView)];
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
    if (_mergeRequests.count == 0) {
        _emptyView.hidden = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        _emptyView.hidden = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return _mergeRequests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MergeRequestCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    GLMergeRequest *mergeRequest = _mergeRequests[indexPath.row];
    [cell setUpWithMergeRequest:mergeRequest];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SingleMergeRequestViewController *mergeVC = [SingleMergeRequestViewController new];
    mergeVC.mergeRequest = _mergeRequests[indexPath.row];
    [self.navigationController pushViewController:mergeVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}


#pragma mark - Private Methods

- (void)fetchData
{
    [[GLGitlabApi sharedInstance] getMergeRequestsForProjectId:self.project.projectId
                                              withSuccessBlock:^(NSArray *mergeRequests) {
                                                  _mergeRequests = [mergeRequests mutableCopy];
                                                  [self.tableView reloadData];
                                              }
                                               andFailureBlock:^(NSError *error) {
                                                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                   message:@"Error fetching merge requests, please try again"
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

- (void)showCreateMergeRequestView
{
    GLNavigationController *tempNav = [[GLNavigationController alloc] initWithRootViewController:[CreateMergeRequestViewController new]];
    tempNav.project = ((GLNavigationController *) self.navigationController).project;
    [self presentViewController:tempNav animated:YES completion:nil];
}

@end