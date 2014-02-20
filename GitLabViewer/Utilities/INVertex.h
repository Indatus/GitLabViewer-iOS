//
//  INVertex.h
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface INVertex : NSObject

@property (nonatomic, assign) int32_t x;
@property (nonatomic, assign) int32_t y;
@property (nonatomic, copy) NSAttributedString *label;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToVertex:(INVertex *)vertex;

- (NSUInteger)hash;

@end