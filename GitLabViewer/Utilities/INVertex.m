//
//  INVertex.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "INVertex.h"

@implementation INVertex

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.x=%i", self.x];
    [description appendFormat:@", self.y=%i", self.y];
    [description appendString:@">"];
    return description;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;
    
    return [self isEqualToVertex:other];
}

- (BOOL)isEqualToVertex:(INVertex *)vertex {
    if (self == vertex)
        return YES;
    if (vertex == nil)
        return NO;
    if (self.x != vertex.x)
        return NO;
    if (self.y != vertex.y)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.x;
    hash = hash * 31u + self.y;
    return hash;
}

@end