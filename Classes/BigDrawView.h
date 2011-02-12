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
#import "nnRateCounter.h"
#import "nnInteractionView.h"
#import <QuartzCore/CoreAnimation.h>



@interface BigDrawView : nnScrollingCGView  <nnInteractionViewDelegate>  {
    BOOL inTouches;
    
    UILabel *dstring1;
    UILabel *dstring2;
    
    BOOL drawing;
    
    nnInteractionView *feedback;
    
    NSMutableArray *sceneList; // Array of scene objects

}

-(void)setupBigDrawView;

-(void)updateWindow;

-(IBAction)panAndZoomMode;
-(IBAction)drawMode;
-(IBAction)clearScene;

-(void)addSceneObject: (nnSceneObject*)object;

@property (nonatomic, retain) IBOutlet nnInteractionView* feedback;

@property (nonatomic, retain) IBOutlet UILabel *dstring1;
@property (nonatomic, retain) IBOutlet UILabel *dstring2;


@end
