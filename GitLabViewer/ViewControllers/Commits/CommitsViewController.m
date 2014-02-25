//
//  CommitsViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CommitsViewController.h"
#import "Constants.h"
#import "CommitCell.h"

static NSString *const kNibName = @"CommitCell";
static NSString *const kCellIdentifier = @"Cell";
static NSString * const kEmptyViewText = @"There are currently no\nCommits in this project.";

@interface CommitsViewController ()
{
    NSMutableArray *_commits;
    UILabel *_emptyView;
}

@end

@implementation CommitsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:kNibName bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:nib forCellReuseIdentifier:kCellIdentifier];

    [self prepareEmptyView];
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
    if (_commits.count == 0) {
        _emptyView.hidden = NO;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        _emptyView.hidden = YES;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    
    return _commits.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommitCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    [cell setUpWithCommit:_commits[indexPath.row]];

    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


#pragma mark - Private Methods

- (void)fetchData
{
    [[GLGitlabApi sharedInstance] getAllCommitsForProjectId:self.project.projectId
                                           withSuccessBlock:^(NSArray *commits) {
                                               _commits = [commits mutableCopy];
                                               [self.tableView reloadData];
    }
                                            andFailureBlock:^(NSError *error) {
                                                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                message:@"Error fetching commits, please try again"
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

@end