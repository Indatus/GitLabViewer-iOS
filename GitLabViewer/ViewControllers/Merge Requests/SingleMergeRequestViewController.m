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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
