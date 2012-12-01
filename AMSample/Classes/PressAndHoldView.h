//
//  PressAndHoldView.h
//  AMSample
//
//  Created by Miles Alden on 2/1/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScopeViewCon.h"
#import "EnumHeader.h"


@interface PressAndHoldView : UIView
{
    int counter;
    UIView *layoutContainer;
    CGPoint location, mainViewLocation;
    CGRect originalFrame;
    NSTimer *timer;
    id owner_;
    
    ContainerState _containerState;
   

    id tgt;
    SEL slr;

}

@property (readonly, retain) UILongPressGestureRecognizer *longPress;
@property (readonly, getter = getDragState) DragState _dragState;
@property (retain) UIView *startingSuperview;
@property (retain)  ScopeViewCon *liveImageView;
@property int intendedViewContainer;

- (void)setOwner_:(id)newOwner;
- (UIView *)getOwner_;
- (UIView *)isInLayoutContainer;
- (ContainerState)getContainerState;
- (CGSize)calculateTransformPercentage: (CGRect)theRect;
-  (void)addLiveImageView;
- (void)setup;
- (void)setTarget: (id)target selector: (SEL)selector;

@end
