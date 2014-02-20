//
//  GLNetworkGraph.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNetworkGraph.h"

@implementation GLNetworkGraph

- (instancetype)initWithCommits:(NSArray *)commits
{
    if (self = [super init]) {
        _commits = commits;
    }
    return self;
}

// return vertices
// return edges

@end