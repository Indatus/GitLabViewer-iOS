//
//  INSimpleGraphView.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class INVertex, INEdge;

@interface INSimpleGraphView : UIView

@property (nonatomic, strong) NSMutableArray *vertices;
@property (nonatomic, strong) NSMutableArray *edges;

- (instancetype)initWithFrame:(CGRect)frame vertices:(NSArray *)vertices andEdges:(NSArray *)edges;

@end