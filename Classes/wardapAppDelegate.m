//
//  wardapAppDelegate.m
//  wardap
//
//  Created by Brice Tebbs on 12/1/10.
//  Copyright 2010 northNitch Studios, Inc. All rights reserved.
//

#import "wardapAppDelegate.h"
#import "wardapViewController.h"

@implementation wardapAppDelegate

@synthesize window;
@synthesize viewController;

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after app launch.
    
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

	return YES;
}

@end
