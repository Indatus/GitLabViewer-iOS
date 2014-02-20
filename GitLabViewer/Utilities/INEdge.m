//
//  INEdge.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "INEdge.h"
#import "INVertex.h"

@implementation INEdge

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.vertex1=%@", self.vertex1];
    [description appendFormat:@", self.vertex2=%@", self.vertex2];
    [description appendString:@">"];
    return description;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;
    
    return [self isEqualToEdge:other];
}

- (BOOL)isEqualToEdge:(INEdge *)edge {
    if (self == edge)
        return YES;
    if (edge == nil)
        return NO;
    if (self.vertex1 != edge.vertex1 && ![self.vertex1 isEqual:edge.vertex1])
        return NO;
    if (self.vertex2 != edge.vertex2 && ![self.vertex2 isEqual:edge.vertex2])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.vertex1 hash];
    hash = hash * 31u + [self.vertex2 hash];
    return hash;
}

@end