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

@interface GLNetworkGraph ()
{
    NSArray *_commits;
    NSArray *_branches;
}

@end

@implementation GLNetworkGraph

- (instancetype)initWithCommits:(NSArray *)commits andBranches:(NSArray *)branches
{
    if (self = [super init]) {
        _commits = commits;
        _branches = branches;
        [self createGraph];
    }
    return self;
}


- (void)createGraph
{
    _vertices = [NSMutableArray new];
    _edges = [NSMutableArray new];
    
    int y = 0;
    int x = -1;
    
    for (GLBranch *b in _branches) {
        INVertex *head = [INVertex new];
        head.x = ++x;
        head.y = y++;
        head.label = [[NSAttributedString alloc] initWithString:b.name];
        [_vertices addObject:head];
        
        GLCommit *c = b.commit;
        
        while (c) {
            NSString *parentSha = c.parents[0];
            
            c = [self commitForSha:parentSha];
            
            INVertex *v = [INVertex new];
            v.x = x;
            v.y = y++;
            [_vertices addObject:v];
        }
    }
    

}

- (GLCommit *)commitForSha:(NSString *)sha
{
    for (GLCommit *c in _commits) {
        if ([c.sha isEqualToString:sha]) {
            return c;
        }
    }
    
    return nil;
}

@end