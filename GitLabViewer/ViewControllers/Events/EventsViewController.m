//
//  EventsViewController.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/7/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "EventsViewController.h"
#import "GLEvent.h"

static NSString *const kCellIdentifier = @"Cell";

@interface EventsViewController ()
@property (nonatomic, strong) NSArray *events;
@end

@implementation EventsViewController

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
    UINib *eventCellNib = [UINib nibWithNibName:@"EventCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:eventCellNib forCellReuseIdentifier:kCellIdentifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fetchData];
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
    return _events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    GLEvent *event = _events[indexPath.row];
    // TODO: Figure out how to display event data?
    cell.textLabel.text = event.description;
    
    return cell;
}

#pragma mark - Private methods

- (void)fetchData
{
    [[GLGitlabApi sharedInstance] getProjectEventsForProject:_project
                                                     success:^(NSArray *eventArray) {
                                                         self.events = eventArray;
                                                         [self.tableView reloadData];
                                                     }
                                                     failure:^(NSError *error) {
                                                         NSLog(@"Error fetching events for project %@", _project);
                                                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error fetching events"
                                                                                                         message:@"Unable to fetch events, please try again"
                                                                                                        delegate:nil
                                                                                               cancelButtonTitle:@"OK"
                                                                                               otherButtonTitles:nil];
                                                         [alert show];
                                                     }];
}

@end
