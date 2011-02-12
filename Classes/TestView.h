//
//  TestView.h
//  wardap
//
//  Created by Brice Tebbs on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>


@interface MyLayer :  CALayer {
}
@property (nonatomic, assign) float lineWidth;
@end

@interface TestView : UIView {
    MyLayer *testLayer;
}

-(IBAction)animateIt;
@end




@interface LayerDelegate : NSObject
{
}
@end