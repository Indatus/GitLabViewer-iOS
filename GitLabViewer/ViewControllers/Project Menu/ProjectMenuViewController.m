//
//  ProjectMenuViewController.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/7/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "ProjectMenuViewController.h"
#import "EventsViewController.h"
#import "IssuesViewController.h"
#import "MergeRequestsViewController.h"

typedef NS_ENUM(NSInteger, ProjectMenuViewControllerOption) {
    ProjectMenuViewControllerOptionEvents,
    ProjectMenuViewControllerOptionIssues,
    ProjectMenuViewControllerOptionMergeRequests
};

static NSString *const kCellIdentifier = @"Cell";

@interface ProjectMenuViewController ()
{
    NSArray *_menuOptions;
}

@end

@implementation ProjectMenuViewController

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
    _menuOptions = @[@"Events", @"Issues", @"Merge Requests"];
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kCellIdentifier];
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
    return _menuOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSString *title = _menuOptions[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseProjectDetailViewController *controller;
    switch (indexPath.row) {
        case ProjectMenuViewControllerOptionEvents:
            controller = [[EventsViewController  alloc] initWithStyle:UITableViewStylePlain];
            break;
        case ProjectMenuViewControllerOptionIssues:
            controller = [[IssuesViewController alloc] initWithStyle:UITableViewStylePlain];
            break;
        case ProjectMenuViewControllerOptionMergeRequests:
            controller = [[MergeRequestsViewController alloc] initWithStyle:UITableViewStylePlain];
        break;
    }
    
    [controller setProject:_project];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
