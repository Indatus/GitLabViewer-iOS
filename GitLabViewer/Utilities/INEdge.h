//
//  INEdge.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class INVertex;

@interface INEdge : NSObject

@property (nonatomic, strong) INVertex *vertex1;
@property (nonatomic, strong) INVertex *vertex2;
@property (nonatomic, strong) UIColor *color;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToEdge:(INEdge *)edge;

- (NSUInteger)hash;

@end