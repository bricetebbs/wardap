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

@implementation BigDrawView

@synthesize dstring1;
@synthesize dstring2;
@synthesize feedback;

- (void)dealloc {
    [dstring1 release];
    [dstring2 release];
    [sceneList removeAllObjects];
    [sceneList release];
    [super dealloc];
}


-(void)updateWindow
{
    [self fitView];  // Fitview is in the base class and just fits the whole world into the view
}


//  Initialize the view for drawing etc.
-(void)setupBigDrawView
{ 
    
    if(!sceneList)
    {
        sceneList = [[NSMutableArray alloc] init];
    }
    
    // Copy the size of this window to the feeback window so they are equal
    
    feedback.frame= self.frame;
    feedback.bounds= self.bounds;

    [self setupScollingCGViewWithMapSize: CGRectMake(0,0, self.bounds.size.width*20, self.bounds.size.height*20)];
    [self setScrollZoomOptions: nnkZoomHorizontal | nnkZoomVertical | nnkScrollingVertical  | nnkScrollingHorizontal];
    
    [self updateWindow];

    [feedback setNeedsDisplay];
}


-(void)addSceneObject:(nnSceneObject *)object
{
    [sceneList addObject: object];
    [self setNeedsDisplay];
}

// Map points from the interaction view to the scaled coordinates of the zoom/scroll view
-(NSArray*)mapPoints: (NSArray*) ptsIn
{       
    NSMutableArray *rval = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSValue* v in ptsIn)
    {
        CGPoint p = [v CGPointValue];
        p.x += scrollOffset.x;
        p.y += scrollOffset.y;
        
        p.x /= zoomScale;
        p.y /= zoomScale;
        [rval addObject: [NSValue valueWithCGPoint:p]];
    }
    return rval;
}


-(void) touchUpPoints: (NSArray*) strokePoints
{
    NSArray *mappedPoints;
    
    // Setup the style for the line we are going to draw
    CGFloat blue[] = {0.0,0.0,1.0,1.0};
    nnDrawStyle* ds = [[nnDrawStyle alloc] init];
    ds.strokeWidth = 3.0;
    [ds setStrokeRGB: blue];
    
    
    // Create the line object and attache the style
    nnSceneBezierPath* bp = [[nnSceneBezierPath alloc] init];
    bp.drawStyle = ds;
    
    // Get the points map them and curvefit then add to the path
    mappedPoints = [self mapPoints: strokePoints];
    [bp setupWithPoints: mappedPoints];
    
    
    // Create a scene object from the path
    nnSceneObject *so = [[nnSceneObject alloc] init];
    [so addPart: bp];
    [self addSceneObject: so];
    
    // Release the objects we don't need since they are in the scene graph now
    [so release];
    [bp release];
    [ds release];
}


-(void)panAndZoomMode
{
    [self setZoomMin:1.0/20.0 andMax: 30.0];
    self.scrollEnabled = YES;
    drawing = NO;
    
    // We don't show the feedback view in pan mode. Feedback is used to show the interaction ghost
    self.feedback.hidden = YES;
}

-(void)drawMode
{
    [self setZoomMin: 1.0 andMax: 1.0];
    self.scrollEnabled = NO;
    drawing = YES;
    self.feedback.hidden = NO;
}

-(void)clearScene
{
    [sceneList removeAllObjects];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Compensate for the scrolling we have done.
    CGContextTranslateCTM(context, scrollOffset.x, scrollOffset.y);
    
    CGRect worldRect = CGRectMake(rect.origin.x/zoomScale, 
                                  rect.origin.y/zoomScale,
                                  rect.size.width/zoomScale, 
                                  rect.size.height/zoomScale);

    
    // Show the current pan and zoom info as dstring2
    dstring2.text = [NSString stringWithFormat: @"SC:%@ WR=%@",NSStringFromCGPoint(scrollOffset),
                                                               NSStringFromCGRect(worldRect)];
    
    
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    
    // Draw the objects using the current transform
    for (nnSceneObject *so in sceneList)
    {
        [so draw: context withTransform:worldToViewTransform];
    }
    
    CGContextSaveGState(context);
    CGContextConcatCTM(context, worldToViewTransform);
    // Draw Stuff in directly in world Coordinates
    CGContextRestoreGState(context);
    
    
}

@end
