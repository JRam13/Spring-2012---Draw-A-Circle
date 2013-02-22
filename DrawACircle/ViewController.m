//
//  ViewController.m
//  DrawACircle
//
//  Created by T. Binkowski on 5/4/12.
//  Copyright (c) 2012 University of Chicago. All rights reserved.
//

#import "ViewController.h"
#import "CircleGestureRecognizer.h"
#import "DoodleView.h"
#import "CircleView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface ViewController ()

@end


@implementation ViewController

@synthesize doodleView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Load Circle view
    CGRect window = [[UIScreen mainScreen] bounds];
    self.circleView = [[CircleView alloc] initWithFrame:window];

    // Load the doodle view
    window = [[UIScreen mainScreen] bounds];
    self.doodleView = [[DoodleView alloc] initWithFrame:window];
    
    CircleGestureRecognizer *recognizer = [[CircleGestureRecognizer alloc] initWithTarget:self action:@selector(handleCircleRecognizer:)]; 
	[self.doodleView addGestureRecognizer:recognizer];
    [self.view addSubview:self.doodleView];
    [self.view addSubview:self.circleView];
    
    //Add info button
    UIButton *infoBut = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [infoBut addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.doodleView addSubview:infoBut];
    
    
}

-(void)soundEffects:(id)blah
{
    NSString *sndPath = [[NSBundle mainBundle] pathForResource:@"BUZZER" ofType:@"wav"];
    NSURL *sndURL = [NSURL fileURLWithPath:sndPath];
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)sndURL, &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, NULL, NULL);
    AudioServicesPlaySystemSound(soundID);
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
}

#pragma mark - Orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Recognizer Delegate

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void) handleCircleRecognizer:(UIGestureRecognizer *) recognizer
{
	UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Circle Recognizer"
                                                      message:@"Circle has been recognized, good job!"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    [message show];
    [self.doodleView setPathColor:[UIColor redColor]];
}



#pragma mark - Shake
/*******************************************************************************
 * @method      <# method #>
 * @abstract    Let the view controller respond to motion events
 * @description <# description #>
 *******************************************************************************/
- (BOOL)canBecomeFirstResponder {
    return YES;
}

/*******************************************************************************
 * @method      <# method #>
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //if (motion != UIEventSubtypeMotionShake) return; 
}

/*******************************************************************************
 * @method       method 
 * @abstract    <# abstract #>
 * @description <# description #>
 *******************************************************************************/
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventTypeMotion && event.type == UIEventSubtypeMotionShake) {
        NSLog(@"Motion Ended on %@", [NSDate date]);
        [self.doodleView clear];
    }
    if ([super respondsToSelector:@selector(motionEnded:withEvent:)]) {
        [super motionEnded:motion withEvent:event];
    }
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {}

-(IBAction)buttonClicked:(id)sender
{
    UIActionSheet *info = [[UIActionSheet alloc] initWithTitle:@"Instructions: Trace the circle as best as you can! Shake to erase."
                                                      delegate:nil
                                             cancelButtonTitle:@"Ok"
                                        destructiveButtonTitle:nil
                                             otherButtonTitles:nil, nil];
    [info showInView:self.view];

}
@end
