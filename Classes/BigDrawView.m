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
    
    if(!sceneList)
    {
        sceneList = [[NSMutableArray alloc] init];
    }
    

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
    CGFloat blue[] = {0.0,0.0,1.0,1.0};
    nnDrawStyle* ds = [[nnDrawStyle alloc] init];
    nnSceneBezierPath* bp = [[nnSceneBezierPath alloc] init];
    ds.strokeWidth = 3.0;
    [ds setStrokeRGB: blue];
    bp.drawStyle = ds;
    
    mappedPoints = [self mapPoints: strokePoints];
    
    [bp setupWithPoints: mappedPoints];
    nnSceneObject *so = [[nnSceneObject alloc] init];
    [so addPart: bp];
    [self addSceneObject: so];
    [so release];
    [bp release];
    [ds release];
}





-(void)panAndZoomMode
{
    [self setZoomMin:1.0/20.0 andMax: 30.0];
    self.scrollEnabled = YES;
    drawing = NO;
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
    
    
}

@end
