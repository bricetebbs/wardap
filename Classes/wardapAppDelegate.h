//
//  wardapAppDelegate.h
//  wardap
//
//  Created by Brice Tebbs on 12/1/10.
//  Copyright 2010 northNitch Studios, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class wardapViewController;

@interface wardapAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    wardapViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet wardapViewController *viewController;

@end

