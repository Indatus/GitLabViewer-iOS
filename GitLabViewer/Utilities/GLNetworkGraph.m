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
    _edges = [NSMutableArray new];
    
    int y = 0;
    int x = 0;
    
    for (GLBranch *b in branches) {
        INVertex *vHead = [INVertex new];
        vHead.x = x++;
        vHead.y = y++;
        vHead.label = [[NSAttributedString alloc] initWithString:b.name];
        
        GLCommit *c = b.commit;
        
        while (c.parents) {
            NSString *parentSha = c.parents[0];
            
            for (GLCommit *commit in commits) {
                if ([commit.sha isEqualToString:parentSha]) {
                    c = commit;
                }
            }
            
            INVertex *v = [INVertex new];
            v.x = x;
            v.y = y++;
        }
    }
    

}

@end