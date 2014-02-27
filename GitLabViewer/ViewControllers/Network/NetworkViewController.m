//
//  NetworkViewController.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/11/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "NetworkViewController.h"
#import "INVertex.h"
#import "INEdge.h"
#import "INSimpleGraphView.h"
#import "GLNetworkGraph.h"

@interface NetworkViewController ()

@end

@implementation NetworkViewController

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
    
    /* ---- Branch names ---- */
    
    NSAttributedString *masterBranch = [[NSAttributedString alloc] initWithString:@"master" attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Noteworthy-Bold" size:12],
                                                                                                          NSBackgroundColorAttributeName: [UIColor blackColor],
                                                                                                          NSStrokeColorAttributeName: [UIColor whiteColor]}];
    
    NSAttributedString *developBranch = [[NSAttributedString alloc] initWithString:@"develop" attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Noteworthy-Bold" size:12],
                                                                                                            NSBackgroundColorAttributeName: [UIColor blackColor],
                                                                                                            NSStrokeColorAttributeName: [UIColor whiteColor]}];
    
    NSAttributedString *deployBranch = [[NSAttributedString alloc] initWithString:@"deploy" attributes:@{ NSFontAttributeName: [UIFont fontWithName:@"Noteworthy-Bold" size:12],
                                                                                                          NSBackgroundColorAttributeName: [UIColor blackColor],
                                                                                                          NSStrokeColorAttributeName: [UIColor whiteColor]}];
    
    [[GLGitlabApi sharedInstance] getAllCommitsForProjectId:_project.projectId
                                           withSuccessBlock:^(NSArray *commits) {
                                               [[GLGitlabApi sharedInstance] getRepoBranchesForProject:_project
                                                                                               success:^(NSArray *branches) {
                                                                                                   GLNetworkGraph *networkGraph = [[GLNetworkGraph alloc] initWithCommits:commits andBranches:branches];
            
            
                                                                                                   NSLog(@"vertices are: %@", networkGraph.vertices);
            
                                                                                                   UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
            
                                                                                                   INSimpleGraphView *graphView = [[INSimpleGraphView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)
                                                                                                                                                                  vertices:networkGraph.vertices
                                                                                                                                                                  andEdges:networkGraph.edges];
                                                                                                   graphView.backgroundColor = [UIColor whiteColor];
            
                                                                                                   [scollView addSubview:graphView];
                                                                                                   scollView.contentSize = graphView.frame.size;
                                                                                                   [self.view addSubview:scollView];
  
                                                                                               }
                                                                                               failure:^(NSError *error) {
                                                                                                   NSLog(@"Failed to retrieve branches inside the NetworkViewController");
                                                                                               }];
    }
                                            andFailureBlock:^(NSError *error) {
        NSLog(@"Failed to retrieve commits inside the NetworkViewController");
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void)fetchData
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fixme"
                                                    message:@"I haven't been implemented yet, please fix."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end