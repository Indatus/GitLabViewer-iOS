//
//  ProjectMenuViewController.m
//  GitLabViewer
//
//  Created by Jeff Trespalacios on 2/6/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "ProjectMenuViewController.h"

typedef NS_ENUM(NSInteger, ProjectMenuButtons) {
    ProjectMenuViewControllerEvents = 1,
    ProjectMenuViewControllerIssues,
    ProjectMenuViewControllerMergeRequests
};

@interface ProjectMenuViewController ()

@end

@implementation ProjectMenuViewController

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
	NSArray *buttonNames = @[@"Events", @"Issues", @"Merge Requests"];
    
    int i = 1;
    for (NSString *buttonName in buttonNames) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:buttonName
                forState:UIControlStateNormal];
        button.tag = i;
        i++;
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
