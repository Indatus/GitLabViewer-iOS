//
//  SingleCommitViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "SingleCommitViewController.h"
#import "Constants.h"

@interface SingleCommitViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblSha;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthorName;
@property (weak, nonatomic) IBOutlet UILabel *lblAuthorEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblCreatedAt;
@property (weak, nonatomic) IBOutlet UILabel *lblParentSha;

@end

@implementation SingleCommitViewController

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

    _lblSha.text = _commit.sha;
    _lblTitle.text = _commit.title;
    _lblAuthorName.text = _commit.authorName;
    _lblAuthorEmail.text = _commit.authorEmail;
    _lblCreatedAt.text = [[Constants standardFormatter] stringFromDate:_commit.createdAt];
    _lblParentSha.text = _commit.parents[0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end