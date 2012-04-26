//
//  TestView.h
//  wardap
//
//  Created by Brice Tebbs on 2/11/11.
//  Copyright 2011 northNitch.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>


// A CALayer where we will animate the lineWidth
@interface MyLayer :  CALayer {
}
@property (nonatomic, assign) float lineWidth;
@end

// This is just a simple view for testing an animation layer


@interface TestView : UIView {
    MyLayer *testLayer;
}

-(IBAction)animateIt;
@end


@interface LayerDelegate : NSObject
{
}
@end