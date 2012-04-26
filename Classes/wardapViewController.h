//
//  wardapViewController.h
//  wardap
//
//  Created by Brice Tebbs on 12/1/10.
//  Copyright 2010 northNitch Studios, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigDrawView.h"

#import "TestView.h"

@interface wardapViewController : UIViewController {
    
    // The view we are doing the drawing onto
    IBOutlet BigDrawView *drawView;
    
    // A View for holding the controls
    IBOutlet UIView *controlPanel;
    
    // A view for the full window
    IBOutlet UIView *mainView;
    
    // A test view for playing around with CA Layer animation
    IBOutlet TestView *testView;
    
    // The mode control
    IBOutlet UISegmentedControl *mode;
   }

-(IBAction)modeChanged: (UISegmentedControl*)sender;
@end

