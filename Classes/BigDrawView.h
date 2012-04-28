//
//  BigDrawView.h
//  wardap
//
//  Created by Brice Tebbs on 12/1/10.
//  Copyright 2010 northNitch Studios, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "nnScrollingCGView.h"

#import "nnSceneObject.h"
#import "nnInteractionView.h"
#import <QuartzCore/CoreAnimation.h>

// THe main class for drawing the view. A subclass of UIScrollView 
// which also includes a nnInteractionView for showing user feedback.


@interface BigDrawView : nnScrollingCGView  <nnInteractionViewDelegate>  {
    BOOL inTouches;
    
    // Some labels to draw on the control panel
    UILabel *dstring1;
    UILabel *dstring2;
    
    BOOL drawing;  // Current mode
    
    nnInteractionView *feedback; // View layer that sits on top an watches for touches when we aren't drawing
    
    NSMutableArray *sceneList; // Array of scene objects

}

// Setup the view based on the views attached in the .xib
-(void)setupBigDrawView;

// Needed when we rotate the view to reset everything
-(void)updateWindow;

// Switch UI to pan/zoom mode
-(IBAction)panAndZoomMode;

// Switch UI to draw mode
-(IBAction)drawMode;

// Clear the scene (erase the screen)
-(IBAction)clearScene;

// Add an object to the scene
-(void)addSceneObject: (nnSceneObject*)object;


// Outlets for IB
@property (nonatomic, retain) IBOutlet nnInteractionView* feedback;
@property (nonatomic, retain) IBOutlet UILabel *dstring1;
@property (nonatomic, retain) IBOutlet UILabel *dstring2;


@end
