//
//  TestView.m
//  wardap
//
//  Created by Brice Tebbs on 2/11/11.
//  Copyright 2011 northNitch Studios Inc. All rights reserved.
//



#import "TestView.h"

@implementation MyLayer
@synthesize lineWidth;

// Here we are telling the base class that if the lineWidth changes then we need to redraw
// if the key is not lineWidth we go with the base class's function
+ (BOOL)needsDisplayForKey:(NSString*)key {
    
    if ([key isEqualToString:@"lineWidth"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

// This is called by the layer animation to update the content
-(void)drawInContext:(CGContextRef)theContext
{
    CGContextSetLineWidth(theContext,self.lineWidth);
    CGContextMoveToPoint(theContext, 0.0, 0.0);
    CGContextAddLineToPoint(theContext, 100, 100);
    CGContextStrokePath(theContext);
}
@end


@implementation TestView

// Setup some default stuff for the animation layer
-(void)awakeFromNib
{
    // Configure the animation layer when we wake up
    
    testLayer = [[MyLayer alloc] init];
    testLayer.position=CGPointMake(100.0f,100.0f);
    testLayer.bounds=CGRectMake(0.0f,0.0f,200.0f,200.0f);
    
    UIImage *image = [UIImage imageNamed:@"57.png"];
    CGImageRef imageRef = [image CGImage];
    
    testLayer.contents = (id)imageRef;    
    [self.layer addSublayer: testLayer];
    
} 

// Setup a test animation to see how it all works
-(void)animateIt
{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"lineWidth"];
    theAnimation.duration=4.0;
    theAnimation.repeatCount=2;
    theAnimation.autoreverses=YES;
    theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
    theAnimation.toValue=[NSNumber numberWithFloat:100.0];
    [testLayer addAnimation:theAnimation forKey:@"animateLineWidth"];
}

@end
