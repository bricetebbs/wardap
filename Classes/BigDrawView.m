//
//  BigDrawView.m
//  wardap
//
//  Created by Brice Tebbs on 12/1/10.
//  Copyright 2010 northNitch Studios, Inc. All rights reserved.
//

#import "BigDrawView.h"
#import "northNitch.h"
#import "nnSceneBezierPath.h"

NSInteger TOUCH_LINE_WIDTH = 10;

@implementation BigDrawView

@synthesize dstring1;
@synthesize dstring2;
@synthesize interact_delegate;


- (void)dealloc {
    [dragPoints release];
    [dstring1 release];
    [dstring2 release];
    [sceneList removeAllObjects];
    [sceneList release];
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}


-(void)updateWindow
{
    [self fitView];
}
-(void)setupBigDrawView
{ 
    [self setupScollingCGViewWithMapSize: CGRectMake(0,0, self.bounds.size.width*20, self.bounds.size.height*20)];

    
    [self setScrollZoomOptions: nnkZoomHorizontal | nnkZoomVertical | nnkScrollingVertical  | nnkScrollingHorizontal];
    

    [self updateWindow];
            
    if(!sceneList)
    {
        sceneList = [[NSMutableArray alloc] init];
    }
}


-(void)panAndZoomMode
{
    [self setZoomMin:1.0/20.0 andMax: 30.0];
    self.scrollEnabled = YES;
    drawing = NO;
}

-(void)drawMode
{
    [self setZoomMin: 1.0 andMax: 1.0];
    self.scrollEnabled = NO;
    drawing = YES;
}

-(void)clearScene
{
    [sceneList removeAllObjects];
    [self setNeedsDisplay];
}

-(void)drawTouches: (CGContextRef) context
{
    int i;
    CGPoint point;
    
    
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, TOUCH_LINE_WIDTH);
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 0.0, 1.0);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    
    for(i = 0; i < [dragPoints count]; i++)
    {
        point = [[dragPoints objectAtIndex: i] CGPointValue];
        point = CGPointApplyAffineTransform(point, worldToViewTransform);
        if (i == 0)
            CGContextMoveToPoint(context, point.x, point.y);
        else
            CGContextAddLineToPoint(context, point.x, point.y);
    }
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}



- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    // Compensate for the scrolling we have done.
    CGContextTranslateCTM(context, scrollOffset.x, scrollOffset.y);
    
    CGRect worldRect = CGRectMake(rect.origin.x/zoomScale, 
                                  rect.origin.y/zoomScale,
                                  rect.size.width/zoomScale, 
                                  rect.size.height/zoomScale);
    
    
    
    dstring2.text = [NSString stringWithFormat: @"SC:%@ WR=%@",NSStringFromCGPoint(scrollOffset),NSStringFromCGRect(worldRect)];
    
    
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    for (nnSceneObject *so in sceneList)
    {
        [so draw: context withTransform:worldToViewTransform];
    }
    CGContextSaveGState(context);
    CGContextConcatCTM(context, worldToViewTransform);
    // Draw Stuff in directly in world Coordinates
    CGContextRestoreGState(context);
    
    
    if (inTouches) {
        [self drawTouches: context];
    }
    
}

-(void)addSceneObject:(nnSceneObject *)object
{
    [sceneList addObject: object];
}


-(void)addToTouchArray:(NSSet *)touches outRect:(CGRect*)rect 
{
    CGPoint p;
    p = [[touches anyObject] locationInView:self];
       
    p.x /= zoomScale;
    p.y /= zoomScale;
    
    dstring1.text = [NSString stringWithFormat: @"t=%@",NSStringFromCGPoint(p)];
    
    *rect = CGRectMake(p.x - TOUCH_LINE_WIDTH/2.0,
                       p.y - TOUCH_LINE_WIDTH/2.0,
                       TOUCH_LINE_WIDTH,
                       TOUCH_LINE_WIDTH);
    
    if ([dragPoints count] > 0)
    {
        CGPoint lastP = [[dragPoints lastObject] CGPointValue];
        CGRect r2 = CGRectMake(lastP.x - TOUCH_LINE_WIDTH/2.0,
                               lastP.y- TOUCH_LINE_WIDTH/2.0,
                               TOUCH_LINE_WIDTH,
                               TOUCH_LINE_WIDTH);
        *rect = CGRectUnion(*rect, r2);
    }
    
    [dragPoints addObject: [NSValue valueWithCGPoint: p]];
}



// Handles the start of a touch
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{   
    CGRect dirtyRect;

    if (!drawing)
        return;
    
    if (dragPoints)
        [dragPoints removeAllObjects];
    else 
        dragPoints = [[NSMutableArray alloc] init];
    
    inTouches = YES;
    
    [self addToTouchArray: touches outRect:  &dirtyRect];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGRect dirtyRect;
    
    
    if (!drawing)
        return;

    
    [self addToTouchArray: touches outRect: &dirtyRect];
    
    inTouches = NO;
    
    [self.interact_delegate touchUpPoints: dragPoints];
    
    
    [self setNeedsDisplay];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{  
    CGRect dirtyRect;
    
    if (!drawing)
        return;

    [self addToTouchArray: touches outRect: &dirtyRect];    
    [self setNeedsDisplayInRect:dirtyRect];
    [self setNeedsDisplay];
}

@end
