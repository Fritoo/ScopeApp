//
//  TogglingScrollview.m
//  AMSample
//
//  Created by Miles Alden on 1/29/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import "TogglingScrollview.h"

@implementation TogglingScrollview

- (void)initializeOnState {
    on = YES;
}

- (void)setOn:(BOOL)val {
    
    /*Test if already on screen*/
    if (on) {
        
        /*Here a positive value should do nothing.*/
        if (val) return;
        
        /*While a negative value moves us offscreen.*/
        else {
            
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5f];
            
            /*This means toggle to below*/
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
            self.alpha = 0.0f;
            [self.superview bringSubviewToFront:self];
            
            [UIView commitAnimations];
            
            on = NO;
        }
    }
    
    else {
        
        /*Passed a negative value while already offscreen.*/
        if (!val) return;
        
        else {
            
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.5f];
            
            /*This means toggle to below*/
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - self.frame.size.height, self.frame.size.width, self.frame.size.height);
            self.alpha = 1.0f;
            [self.superview bringSubviewToFront:self];
            
            [UIView commitAnimations];
            
            on = YES;

        }
    }
    
}





- (BOOL)isOn {
    return on;
}
@end
