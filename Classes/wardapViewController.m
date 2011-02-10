//
//  wardapViewController.m
//  wardap
//
//  Created by Brice Tebbs on 12/1/10.
//  Copyright 2010 northNitch Studios, Inc. All rights reserved.
//

#import "wardapViewController.h"
#import "nnSceneBezierPath.h"

@implementation wardapViewController



- (void)dealloc {
    [super dealloc];
}

-(void) touchUpPoints: (NSArray*) strokePoints
{
    CGFloat blue[] = {0.0,0.0,1.0,1.0};
    nnDrawStyle* ds = [[nnDrawStyle alloc] init];
    nnSceneBezierPath* bp = [[nnSceneBezierPath alloc] init];
    ds.strokeWidth = 3.0;
    [ds setStrokeRGB: blue];
    bp.drawStyle = ds;
    [bp setupWithPoints: strokePoints];
    nnSceneObject *so = [[nnSceneObject alloc] init];
    [so addPart: bp];
    [drawView addSceneObject: so];
    [so release];
    [bp release];
    [ds release];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad]; 
    
    [drawView setupBigDrawView];
    [mainView bringSubviewToFront: controlPanel];
    
    drawView.interact_delegate = self;
    
    [drawView drawMode];
}



-(void)modeChanged: (UISegmentedControl*)sender
{   
    if (sender.selectedSegmentIndex == 0)
    {
        [drawView drawMode];
    }
    else if (sender.selectedSegmentIndex == 1)
    {
        [drawView panAndZoomMode];
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [drawView updateWindow];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


@end
