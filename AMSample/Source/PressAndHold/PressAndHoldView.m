//
//  PressAndHoldView.m
//  AMSample
//
//  Created by Miles Alden on 2/1/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import "PressAndHoldView.h"
#import "SideBySideCon.h"
#import "CompareViewAppDelegate.h"


@implementation PressAndHoldView
@synthesize longPress, _dragState, startingSuperview;
@synthesize liveImageView, intendedViewContainer;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        originalFrame = self.frame;
        _dragState = DragStateDisabled;
        _containerState = ContainerStateInStartingView;
        counter = 0;
        
        //[self addLiveImageView];
    }
    return self;
}

- (void)setup {
    
    /*This does the same initialization as
     initWithFrame. I added it here to get it done
     when initializing through IB.*/
    
    originalFrame = self.frame;
    _dragState = DragStateDisabled;
    _containerState = ContainerStateInStartingView;
    counter = 0;
    
    [self addLiveImageView];

}

- (void)setOwner_:(id)newOwner {
    if (newOwner) owner_ = newOwner;
}

- (UIView *)getOwner_ {
    return ( owner_ ) ? owner_ : nil;
}

- (ContainerState)getContainerState {
    return _containerState;
}



- (UIView *)isInLayoutContainer {
    
    UIView *retVal;
    
    for (int i = 0; i < 4; i++) {
        if ( self.superview == [owner_ getLayout:i]) retVal = [owner_ getLayout:i];
    }
    
    
    return retVal; //Returns its layout container if there is one.
}


- (void)logState {
    
    if ( _containerState < 1 ) printf("\nContainerState: ContainerStateInScrollView\n");
    else if ( _containerState == 1 ) printf("\nContainerState: ContainerStateInLayoutContainer\n");
    else if ( _containerState == 2 ) printf("\nContainerState: ContainerStateInMainView\n");
    else printf("\nContainerState: ContainerStateInStartingView\n");
    
}


- (void)setTarget: (id)tg selector: (SEL)sl {
    
    tgt = tg;
    slr = sl;
    
}


//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//	
//    printf("began");
//    if ( tgt && slr ) [tgt performSelector:slr withObject:self];
//    
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if ( tgt && slr ) [tgt performSelector:slr withObject:self];

}

-  (void)addLiveImageView {
    
    self->liveImageView = [[ScopeViewCon alloc] init];
//    [liveImageView setup];
    
    liveImageView.view.backgroundColor = [UIColor brownColor];
    liveImageView.view.frame = self.bounds;
    
    
    
    [self addSubview:liveImageView.view];
    NSLog(@"\n***\n\n%@\n***\n\n", self.subviews);
}


- (CGSize)calculateTransformPercentage: (CGRect)theRect {
    
    float newWidth = theRect.size.width / self.frame.size.width; /*Calculate what percentage our width is
                                                                  in relation to theRect width.*/
    float newHeight = theRect.size.height / self.frame.size.height; /*Same for height.*/
    
    printf("\nnewWidth: %f\tnewHeight: %f\n", newWidth, newHeight);
    
    return CGSizeMake(newWidth, newHeight);
}


- (void)reset {
    
    self.transform = CGAffineTransformIdentity;
    
    [self removeFromSuperview];
    [startingSuperview addSubview:self];
    
    layoutContainer = nil;
    _dragState = DragStateDisabled;
    _containerState = ContainerStateInStartingView;
    
    
}

- (BOOL)canBecomeFirstResponder { return YES; }
- (BOOL)canResignFirstResponder { return YES; }



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
