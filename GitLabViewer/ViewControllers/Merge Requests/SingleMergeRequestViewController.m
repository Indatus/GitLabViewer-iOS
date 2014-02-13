//
//  SingleMergeRequestViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "SingleMergeRequestViewController.h"

@interface SingleMergeRequestViewController ()

@property (weak, nonatomic) IBOutlet UILabel *txtTitle;
@property (weak, nonatomic) IBOutlet UILabel *txtSourceBranch;
@property (weak, nonatomic) IBOutlet UILabel *txtTargetBranch;
@property (weak, nonatomic) IBOutlet UILabel *txtAuthor;
@property (weak, nonatomic) IBOutlet UILabel *txtUpvotes;
@property (weak, nonatomic) IBOutlet UILabel *txtDownvotes;

@end

@implementation SingleMergeRequestViewController

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

    _txtTitle.text = _mergeRequest.title;
    _txtSourceBranch.text = _mergeRequest.sourceBranch;
    _txtTargetBranch.text = _mergeRequest.targetBranch;
    _txtAuthor.text = _mergeRequest.author.name;
    _txtUpvotes.text = [NSString stringWithFormat:@"%i", _mergeRequest.upvotes];
    _txtDownvotes.text = [NSString stringWithFormat:@"%i", _mergeRequest.downvotes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Custom IBActions

- (IBAction)btnUpvoteClicked:(id)sender
{
    // TODO: make a connection to change the number of upvotes
}

- (IBAction)btnDownvoteClicked:(id)sender
{
    // TODO: make a connection to change the number of downvotes
}

- (IBAction)btnAcceptMergeClicked:(id)sender
{
    // TODO: make a connection to accept the merge request
}


@end