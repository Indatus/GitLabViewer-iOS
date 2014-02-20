//
//  INSimpleGraphView.m
//  GitLabViewer
//
//  Created by Jon Staff on 2/20/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "INSimpleGraphView.h"
#import "INVertex.h"
#import "INEdge.h"
#import <CoreText/CoreText.h>

static const int kSizeMultiplier = 50;
static const int kPaddingLeft = 20;
static const int kPaddingTop = 20;

@implementation INSimpleGraphView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame vertices:(NSArray *)vertices andEdges:(NSArray *)edges
{
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kPaddingTop * 2 + vertices.count * kSizeMultiplier)]; // re-size the height of the view based on how many vertices there are
    if (self) {
        _vertices = [vertices mutableCopy];
        _edges = [edges mutableCopy];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(context, .5, .1, .3, 1);
    CGContextSetLineWidth(context, 4);
    
    for (INEdge *e in _edges) {
        CGPoint point1 = CGPointMake((e.vertex1.x * kSizeMultiplier) + kPaddingLeft, (e.vertex1.y * kSizeMultiplier) + kPaddingTop);
        CGPoint point2 = CGPointMake((e.vertex2.x * kSizeMultiplier) + kPaddingLeft, (e.vertex2.y * kSizeMultiplier) + kPaddingTop);
        
        if (e.vertex2.x == 1) {
            CGContextSetRGBStrokeColor(context, .1, .3, .7, 1);
        }
        
        if (e.vertex2.x == 2) {
            CGContextSetRGBStrokeColor(context, .8, .9, .4, 1);
        }
        
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextStrokePath(context);
    }
    
    for (INVertex *v in _vertices) {
        CGPoint point = CGPointMake((v.x * kSizeMultiplier) + kPaddingLeft, (v.y * kSizeMultiplier) + kPaddingTop);
        CGContextFillEllipseInRect(context, CGRectMake(point.x - 5, point.y - 5, 10, 10));
        
        if (v.label) {
            CGContextSetTextMatrix(context, CGAffineTransformMakeScale(1.0f, -1.0f));
            CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef) v.label);
            CGContextSetTextPosition(context, point.x + 10, point.y + 5);
            CTLineDraw(line, context);
            CFRelease(line);
        }
    }
}

@end
