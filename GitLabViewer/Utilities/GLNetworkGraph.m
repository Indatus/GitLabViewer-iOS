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

- (instancetype)initWithCommits:(NSArray *)commits
{
    if (self = [super init]) {
        [self createVerticesAndEdgesFromCommits:commits];
    }
    return self;
}

- (instancetype)initWithProjectId:(int64_t)projectId
{
    if (self = [super init]) {
        [[GLGitlabApi sharedInstance] getAllCommitsForProjectId:projectId withSuccessBlock:^(NSArray *commits) {
            NSLog(@"commits: %@", commits);
            [self createVerticesAndEdgesFromCommits:commits];
        } andFailureBlock:^(NSError *error) {
            NSLog(@"Error retrieving commits...");
            NSLog(@"Error: %@", error);
        }];
    }
    return self;
}



- (void)createVerticesAndEdgesFromCommits:(NSArray *)commits
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