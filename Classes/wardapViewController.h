//
//  wardapViewController.h
//  wardap
//
//  Created by Brice Tebbs on 12/1/10.
//  Copyright 2010 northNitch Studios, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BigDrawView.h"
@interface wardapViewController : UIViewController <DrawInteractDelegateProtocol> {
    
    IBOutlet BigDrawView *drawView;
    IBOutlet UIView *controlPanel;
    IBOutlet UIView *mainView;
   }
@end

