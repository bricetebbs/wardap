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

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad]; 
    
    [drawView setupBigDrawView];
    
    // Make sure feedback is in front of the draw view and that control panel is on top of feedback
    [mainView bringSubviewToFront: drawView.feedback];
    [mainView bringSubviewToFront: controlPanel];
    
    drawView.feedback.interactDelegate = drawView;
    
    // Lets start in draw mode so we don't confuse people.
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
