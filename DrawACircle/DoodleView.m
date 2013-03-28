//
//  DoodleView.m
//  doodle
//
//  Created by T. Andrew Binkowski on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DoodleView.h"
#import "CircleGestureRecognizer.h"
#import "ViewController.h"

@implementation DoodleView
@synthesize firstTouch,lastTouch;
@synthesize path;
//@synthesize pathColor;

//bool ended;



/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (id)initWithFrame:(CGRect)frame
{
    
    
    NSLog(@"initWithFrame");
    self = [super initWithFrame:frame];
    if (self) {
        self.multipleTouchEnabled = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    _pathsBlue = [[NSMutableArray alloc] init];
    _pathsRed = [[NSMutableArray alloc] init];
    //pathColor = [UIColor blueColor];
    
    
    return self;
   
    
    
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    
    NSLog(@"TouchesBegan");
	path = [UIBezierPath bezierPath];	
	path.lineWidth = 15.0f;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
	
	UITouch *touch = [touches anyObject];
	[path moveToPoint:[touch locationInView:self]];
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    NSLog(@"TouchesMoved");
	UITouch *touch = [touches anyObject];
	[path addLineToPoint:[touch locationInView:self]];
	[self setNeedsDisplay];
    
}

/*******************************************************************************
 * @method       method 
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TouchesEnded");
	UITouch *touch = [touches anyObject];
	[path addLineToPoint:[touch locationInView:self]];
	[self setNeedsDisplay];
    //ended = YES;
    
    [_pathsBlue addObject:path];

    

}

-(void) redArray
{
    [_pathsRed addObject:_pathsBlue.lastObject];
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
	[self touchesEnded:touches withEvent:event];
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) clear 
{
    
    [self screenShot];
    NSLog(@"Clear");
    [path removeAllPoints];
    [self setNeedsDisplay];
    [_pathsBlue removeAllObjects];
    [_pathsRed removeAllObjects];
    
    
    
}

-(void) screenShot
{
    UIGraphicsBeginImageContext(self.frame.size);
    [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(screenshotImage, nil, nil, nil);
    
    
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) drawRect:(CGRect)rect
{
    
    NSLog(@"DrawRect");
    [[UIColor blueColor] set];
    [path stroke];
    
    
    //draw array of blue
    for (UIBezierPath* p in _pathsBlue){
        [[UIColor blueColor] set];
        [p stroke];
    }
    
    //pathColor = [UIColor blueColor];
    //[pathColor set];
    
    //draw array of red
    for (UIBezierPath* p in _pathsRed){
        [[UIColor redColor] set];
        [p stroke];
        
        
        
    }
}
@end
