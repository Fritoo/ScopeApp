//
//  PressAndHoldImages.h
//  AMSample
//
//  Created by Miles Alden on 1/15/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumHeader.h"

@interface PressAndHoldImages : UIImageView
{
    int counter;
    UIView *layoutContainer;
    CGPoint location, mainViewLocation;
    CGRect originalFrame;
    NSTimer *timer;
    id owner_;
    
    ContainerState _containerState;
}

@property (readonly, strong) UILongPressGestureRecognizer *longPress;
@property (readonly, getter = getDragState) DragState _dragState;
@property int intendedViewContainer;

- (void)setOwner_:(id)newOwner;
- (UIView *)getOwner_;
- (UIView *)isInLayoutContainer;
- (ContainerState)getContainerState;
- (CGSize)calculateTransformPercentage: (CGRect)theRect;



@end
