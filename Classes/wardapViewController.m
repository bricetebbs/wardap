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

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


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
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    [drawView setupBigDrawView];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
