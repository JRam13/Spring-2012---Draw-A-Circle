//
//  CircleView.m
//  Test
//
//  Created by JRamos on 2/19/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    
    //find screen dimensions
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Draw a blue hollow circle
    CGContextSetRGBStrokeColor(ctx, 0, 0, 255, 2);
    CGContextSetLineWidth(ctx, 15);
    CGContextStrokeEllipseInRect(ctx,
                                 CGRectMake(screenWidth/2-100, screenHeight/2-120, 200, 200));
    
    //fade the drawing out
    [CircleView beginAnimations:NULL context:Nil];
    [CircleView setAnimationDuration:5];
    [self setAlpha:0];
    [CircleView commitAnimations];
    
    
    
}

@end
