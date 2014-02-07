//
//  ProjectMenuViewController.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/7/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "ProjectMenuViewController.h"
#import "EventsViewController.h"

typedef NS_ENUM(NSInteger, ProjectMenuViewControllerOption) {
    ProjectMenuViewControllerOptionEvents,
    ProjectMenuViewControllerOptionIssues,
    ProjectMenuViewControllerOptionMergeRequests
};

static NSString *const kCellIdentifier = @"Cell";

@interface ProjectMenuViewController ()
{
    NSArray *menuOptions;
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
    menuOptions = @[@"Events", @"Issues", @"Merge Requests"];
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
    return menuOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    NSString *title = menuOptions[indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}

#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller;
    switch (indexPath.row) {
        case ProjectMenuViewControllerOptionEvents:
            controller = [EventsViewController new];
            [(EventsViewController*)controller setProject:_project];
            break;
            
        case ProjectMenuViewControllerOptionIssues:
            
            break;
        
        case ProjectMenuViewControllerOptionMergeRequests:
            
        break;
    }
    
    if (controller) {
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
