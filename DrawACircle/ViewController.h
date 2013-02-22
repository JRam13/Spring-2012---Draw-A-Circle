//
//  ViewController.h
//  DrawACircle
//
//  Created by T. Binkowski on 5/4/12.
//  Copyright (c) 2012 University of Chicago. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DoodleView;
@class CircleView;

@interface ViewController : UIViewController


@property (strong, nonatomic) CircleView* circleView;
@property (strong, nonatomic) DoodleView* doodleView;

@end
