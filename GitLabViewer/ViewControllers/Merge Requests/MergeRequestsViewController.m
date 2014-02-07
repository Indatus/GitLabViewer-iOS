//
//  MergeRequestsViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/5/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "MergeRequestsViewController.h"

static NSString *const kCellIdentifier = @"Cell";

@interface MergeRequestsViewController ()
{
    NSMutableArray *_mergeRequests;
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _mergeRequests.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    GLMergeRequest *mergeRequest = _mergeRequests[indexPath.row];
    cell.textLabel.text = mergeRequest.title;
    
    return cell;
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

@end
