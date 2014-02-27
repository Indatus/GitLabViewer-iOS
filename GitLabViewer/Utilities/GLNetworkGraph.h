//
//  GLNetworkGraph.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLNetworkGraph : NSObject

@property (nonatomic, strong) NSMutableArray *vertices;
@property (nonatomic, strong) NSMutableArray *edges;

- (instancetype)initWithCommits:(NSArray *)commits andBranches:(NSArray *)branches;

@end