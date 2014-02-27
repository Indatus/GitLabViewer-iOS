//
//  GLNetworkGraph.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNetworkGraph.h"
#import "INVertex.h"
#import "INEdge.h"

@implementation GLNetworkGraph

- (instancetype)initWithCommits:(NSArray *)commits andBranches:(NSArray *)branches
{
    if (self = [super init]) {
        [self createGraphFromCommits:commits andBranches:branches];
    }
    return self;
}


- (void)createGraphFromCommits:(NSArray *)commits andBranches:(NSArray *)branches
{
    _vertices = [NSMutableArray new];
    int i = 0;
    for (GLCommit *c in commits) {
        INVertex *v = [INVertex new];
        v.y = i++;
        
        [_vertices addObject:v];
        NSLog(@"vertex added");
    }
}

@end