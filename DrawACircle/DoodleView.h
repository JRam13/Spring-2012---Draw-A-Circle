//
//  DoodleView.h
//  doodle
//
//  Created by T. Andrew Binkowski on 11/1/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DoodleView : UIView <UIImagePickerControllerDelegate>

@property (assign) CGPoint firstTouch;
@property (assign) CGPoint lastTouch;
@property (strong, nonatomic) UIBezierPath *path;
@property (strong, nonatomic) NSMutableArray *pathsBlue;
@property (strong, nonatomic) NSMutableArray *pathsRed;
//@property (strong, nonatomic) UIColor *pathColor;


- (void) clear;

- (void) redArray;

@end
