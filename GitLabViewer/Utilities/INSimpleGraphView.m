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
static const int kLineWidth = 4;
static const int kVertexRadius = 5;
static const int kVertexDiameter = kVertexRadius * 2;

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
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, kPaddingTop * 3 + vertices.count * kSizeMultiplier)]; // re-size the height of the view based on how many vertices there are
    if (self) {
        _vertices = [vertices mutableCopy];
        _edges = [edges mutableCopy];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, kLineWidth);
    
    for (INEdge *e in _edges) {
        CGPoint point1 = CGPointMake((e.vertex1.x * kSizeMultiplier) + kPaddingLeft, (e.vertex1.y * kSizeMultiplier) + kPaddingTop);
        CGPoint point2 = CGPointMake((e.vertex2.x * kSizeMultiplier) + kPaddingLeft, (e.vertex2.y * kSizeMultiplier) + kPaddingTop);
        
        CGColorRef strokeColor = [e.color CGColor] ?: [[UIColor orangeColor] CGColor];
        const CGFloat *components = CGColorGetComponents(strokeColor);
        
        CGContextSetRGBStrokeColor(context, components[0], components[1], components[2], components[3]);
        
        CGContextMoveToPoint(context, point1.x, point1.y);
        CGContextAddLineToPoint(context, point2.x, point2.y);
        CGContextStrokePath(context);
    }
    
    for (INVertex *v in _vertices) {
        CGPoint point = CGPointMake((v.x * kSizeMultiplier) + kPaddingLeft, (v.y * kSizeMultiplier) + kPaddingTop);
        CGContextFillEllipseInRect(context, CGRectMake(point.x - kVertexRadius, point.y - kVertexRadius, kVertexDiameter, kVertexDiameter));
        
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
