//
//  TestView.m
//  wardap
//
//  Created by Brice Tebbs on 2/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TestView.h"

@implementation MyLayer
@synthesize lineWidth;

+ (BOOL)needsDisplayForKey:(NSString*)key {
    if ([key isEqualToString:@"lineWidth"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

-(void)drawInContext:(CGContextRef)theContext
{
    CGContextSetLineWidth(theContext,self.lineWidth);
    CGContextMoveToPoint(theContext, 0.0, 0.0);
    CGContextAddLineToPoint(theContext, 100, 100);
    CGContextStrokePath(theContext);
}
@end



@implementation TestView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 
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

-(void)refresh
{   
    [testLayer setNeedsDisplay];
//    [self performSelector:@selector(refresh) withObject:nil afterDelay:0.01];
}

-(void)awakeFromNib
{
    
    testLayer = [[MyLayer alloc] init];
    testLayer.position=CGPointMake(100.0f,100.0f);
    testLayer.bounds=CGRectMake(0.0f,0.0f,200.0f,200.0f);
    
    
    UIImage *image = [UIImage imageNamed:@"icon-ipad.png"];
    CGImageRef imageRef = [image CGImage];
    
    testLayer.contents = (id)imageRef;    
    [self.layer addSublayer: testLayer];

}

- (void)dealloc
{
    [super dealloc];
}

@end
