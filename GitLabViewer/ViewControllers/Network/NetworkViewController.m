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

    NSMutableArray *vertices = [NSMutableArray new];
    NSMutableArray *edges = [NSMutableArray new];
    
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
    
    /* ---- Vertices ---- */
    
    INVertex *v0 = [INVertex new];
    v0.x = 0;
    v0.y = 0;
    v0.label = masterBranch;
    [vertices addObject:v0];
    
    INVertex *v1 = [INVertex new];
    v1.x = 0;
    v1.y = 1;
    [vertices addObject:v1];
    
    INVertex *v2 = [INVertex new];
    v2.x = 0;
    v2.y = 2;
    [vertices addObject:v2];
    
    INVertex *v3 = [INVertex new];
    v3.x = 0;
    v3.y = 3;
    [vertices addObject:v3];
    
    INVertex *v4 = [INVertex new];
    v4.x = 1;
    v4.y = 4;
    v4.label = developBranch;
    [vertices addObject:v4];
    
    INVertex *v5 = [INVertex new];
    v5.x = 1;
    v5.y = 5;
    [vertices addObject:v5];
    
    INVertex *v6 = [INVertex new];
    v6.x = 1;
    v6.y = 6;
    [vertices addObject:v6];
    
    INVertex *v7 = [INVertex new];
    v7.x = 0;
    v7.y = 7;
    [vertices addObject:v7];
    
    INVertex *v8 = [INVertex new];
    v8.x = 0;
    v8.y = 8;
    [vertices addObject:v8];
    
    INVertex *v9 = [INVertex new];
    v9.x = 0;
    v9.y = 9;
    [vertices addObject:v9];
    
    INVertex *v10 = [INVertex new];
    v10.x = 0;
    v10.y = 10;
    [vertices addObject:v10];
    
    INVertex *v11 = [INVertex new];
    v11.x = 0;
    v11.y = 11;
    [vertices addObject:v11];
    
    INVertex *v12 = [INVertex new];
    v12.x = 0;
    v12.y = 12;
    [vertices addObject:v12];
    
    INVertex *v13 = [INVertex new];
    v13.x = 2;
    v13.y = 13;
    v13.label = deployBranch;
    [vertices addObject:v13];
    
    INVertex *v14 = [INVertex new];
    v14.x = 0;
    v14.y = 14;
    [vertices addObject:v14];
    
    INVertex *v15 = [INVertex new];
    v15.x = 0;
    v15.y = 15;
    [vertices addObject:v15];
    
    /* ---- Edges ----- */
    
    INEdge *e0 = [INEdge new];
    e0.vertex1 = v0;
    e0.vertex2 = v1;
    [edges addObject:e0];
    
    INEdge *e1 = [INEdge new];
    e1.vertex1 = v1;
    e1.vertex2 = v2;
    [edges addObject:e1];
    
    INEdge *e2 = [INEdge new];
    e2.vertex1 = v2;
    e2.vertex2 = v3;
    [edges addObject:e2];
    
    INEdge *e3 = [INEdge new];
    e3.vertex1 = v3;
    e3.vertex2 = v7;
    [edges addObject:e3];
    
    INEdge *e4 = [INEdge new];
    e4.vertex1 = v4;
    e4.vertex2 = v5;
    [edges addObject:e4];
    
    INEdge *e5 = [INEdge new];
    e5.vertex1 = v5;
    e5.vertex2 = v6;
    [edges addObject:e5];
    
    INEdge *e6 = [INEdge new];
    e6.vertex1 = v6;
    e6.vertex2 = v7;
    [edges addObject:e6];
    
    INEdge *e7 = [INEdge new];
    e7.vertex1 = v7;
    e7.vertex2 = v8;
    [edges addObject:e7];
    
    INEdge *e8 = [INEdge new];
    e8.vertex1 = v8;
    e8.vertex2 = v9;
    [edges addObject:e8];
    
    INEdge *missedOne = [INEdge new];
    missedOne.vertex1 = v9;
    missedOne.vertex2 = v10;
    [edges addObject:missedOne];
    
    INEdge *e9 = [INEdge new];
    e9.vertex1 = v10;
    e9.vertex2 = v11;
    [edges addObject:e9];
    
    INEdge *e10 = [INEdge new];
    e10.vertex1 = v11;
    e10.vertex2 = v12;
    [edges addObject:e10];
    
    INEdge *e11 = [INEdge new];
    e11.vertex1 = v12;
    e11.vertex2 = v14;
    [edges addObject:e11];
    
    INEdge *e12 = [INEdge new];
    e12.vertex1 = v13;
    e12.vertex2 = v14;
    [edges addObject:e12];
    
    INEdge *e13 = [INEdge new];
    e13.vertex1 = v14;
    e13.vertex2 = v15;
    [edges addObject:e13];
    
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    INSimpleGraphView *graph = [[INSimpleGraphView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)
                                                               vertices:vertices
                                                               andEdges:edges];
    graph.backgroundColor = [UIColor whiteColor];
    
    [scollView addSubview:graph];
    
    scollView.contentSize = graph.frame.size;
    
    [self.view addSubview:scollView];
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
