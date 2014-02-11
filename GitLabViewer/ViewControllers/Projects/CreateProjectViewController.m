//
//  CreateProjectViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "CreateProjectViewController.h"

@interface CreateProjectViewController ()

@property (weak, nonatomic) IBOutlet UITextField *inputTitle;
@property (weak, nonatomic) IBOutlet UITextField *inputDescription;
@property (weak, nonatomic) IBOutlet UISwitch *switchIssues;
@property (weak, nonatomic) IBOutlet UISwitch *switchWall;
@property (weak, nonatomic) IBOutlet UISwitch *switchMergeRequests;
@property (weak, nonatomic) IBOutlet UISwitch *switchWiki;
@property (weak, nonatomic) IBOutlet UISwitch *switchSnippets;
@property (weak, nonatomic) IBOutlet UISwitch *switchPublic;

@end

@implementation CreateProjectViewController

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
    
    self.title = @"Create Project";
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelModal)];
    self.navigationItem.leftBarButtonItem = cancelButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom IBActions

- (IBAction)btnCreateClicked:(id)sender
{
    
}


#pragma mark - Custom Methods

- (void)cancelModal
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
