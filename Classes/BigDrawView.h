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

@protocol DrawInteractDelegateProtocol
-(void) touchUpPoints: (NSArray*) strokePoints; 
@end


@interface BigDrawView : nnScrollingCGView {
    NSMutableArray *dragPoints;
    BOOL inTouches;
    
    
    UILabel *dstring1;
    UILabel *dstring2;
    
    BOOL drawing;
    
    NSMutableArray *sceneList; // Array of scene objects

    id <DrawInteractDelegateProtocol> interact_delegate;
}

-(void)setupBigDrawView;

-(IBAction)panAndZoomMode;
-(IBAction)drawMode;
-(IBAction)clearScene;
-(void)addSceneObject: (nnSceneObject*)object;

@property (nonatomic, assign) id <DrawInteractDelegateProtocol> interact_delegate;

@property (nonatomic, retain) IBOutlet UILabel *dstring1;
@property (nonatomic, retain) IBOutlet UILabel *dstring2;


@end
