//
//  SingleIssueViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "SingleIssueViewController.h"

@interface SingleIssueViewController ()

@property (weak, nonatomic) IBOutlet UILabel *txtAuthor;
@property (weak, nonatomic) IBOutlet UILabel *txtAssignee;
@property (weak, nonatomic) IBOutlet UILabel *txtCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *txtUpdatedAt;
@property (weak, nonatomic) IBOutlet UILabel *txtMilestone;
@property (weak, nonatomic) IBOutlet UILabel *txtStatus;
@property (weak, nonatomic) IBOutlet UITextView *txtDescription;

@end

@implementation SingleIssueViewController

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
    // Do any additional setup after loading the view from its nib.
    
    self.title = _issue.title;
    
    _txtAuthor.text = _issue.author.name;
    _txtAssignee.text = _issue.assignee.name;
    _txtCreatedAt.text = _issue.createdAt.description;
    _txtUpdatedAt.text = _issue.updatedAt.description;
    _txtMilestone.text = _issue.milestone.title;
    _txtStatus.text = _issue.state;
    _txtDescription.text = _issue.issueDescription;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
