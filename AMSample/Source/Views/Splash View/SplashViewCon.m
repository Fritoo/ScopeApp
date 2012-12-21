//
//  SplashViewCon.m
//  AMSample
//
//  Created by Miles Alden on 7/14/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import "SplashViewCon.h"


@implementation SplashViewCon


- (void)viewDidLoad
{
    
    [self showSTR_Splash];
    
}

- (void)setDelegate:(id)del {delegate = del;}


- (void)showSTR_Splash
{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"STR_Logo_only" ofType:@"png"];
    NSString *path_1 = [[NSBundle mainBundle] pathForResource:@"STR_Slogan" ofType:@"png"];
    
    
    logo.image = [UIImage imageWithContentsOfFile:path];
    slogan.image = [UIImage imageWithContentsOfFile:path_1];
    
    //    CGSize theSize = [[UIScreen mainScreen] bounds].size;
//    CGRect newRect = CGRectMake(0, 0, 79, 80);
//    splash_0.frame = newRect;
    logo.alpha = 0.0;
    
//    newRect = CGRectMake(80, 0, 465/2, 80);
//    splash_1.frame = newRect;
    slogan.alpha = 0.0;
    
    
    [UIView beginAnimations:@"str_splash" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(fadeInFinished)];
    
    logo.alpha = 1.0;
    slogan.alpha = 1.0;
    
    [UIView commitAnimations];
    
    
    
}

- (void)fadeInFinished
{
    [UIView beginAnimations:@"str_splash" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(firstHalfSpinFinished)];
    
    logo.transform = CGAffineTransformMakeScale(0.01, 1.2);
    
    [UIView commitAnimations];
    
}

- (void)firstHalfSpinFinished
{
    
    [UIView beginAnimations:@"str_splash" context:nil];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(secondHalfSpinFinished)];
    
    logo.transform = CGAffineTransformMakeScale(1.0, 1.0);
    
    [UIView commitAnimations];
    
}

- (void)secondHalfSpinFinished
{
    logo.transform = CGAffineTransformIdentity;
    if ( delegate ) [delegate performSelector:@selector(completedSplash) withObject:nil afterDelay:1.0];
//  [window addSubview:viewController.view];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


@end
