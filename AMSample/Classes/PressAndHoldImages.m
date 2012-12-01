//
//  PressAndHoldImages.m
//  AMSample
//
//  Created by Miles Alden on 1/15/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import "PressAndHoldImages.h"
#import "SideBySideCon.h"

@implementation PressAndHoldImages

@synthesize longPress, _dragState, intendedViewContainer;

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    originalFrame = self.frame;
    _dragState = DragStateDisabled;
    _containerState = ContainerStateInScrollView;
    counter = 0;

//    self->longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(didLongPress)];
//    [self addGestureRecognizer:longPress];
    
    return self;

}

- (void)setOwner_:(id)newOwner {
    if (newOwner) owner_ = newOwner;
    [owner_ retain];
}

- (UIView *)getOwner_ {
    return ( owner_ ) ? owner_ : nil;
}

- (ContainerState)getContainerState {
    return _containerState;
}

- (void)didLongPress {
    
    _dragState = DragStateEnabled;
}

- (void)testLongPress {
    
    printf("counter: %d",counter);
    counter++;
    if (counter > 1){
        
//        CGPoint newCenter = [self.superview convertPoint:self.center toView:[owner_ view]];
        [self removeFromSuperview]; /*Kill actual superview*/
        [[owner_ view] addSubview:self]; /*Move to the other superview*/
        
        self.center = mainViewLocation;
        [[owner_ view] bringSubviewToFront:self];
        [[owner_ clientImagesScroller] setScrollEnabled: NO];

        _dragState = DragStateEnabled;
        counter = 0;

        [timer invalidate];
        self->timer = nil;
        
    }
    
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
    else if ( _containerState > 1 ) printf("\nContainerState: ContainerStateInLayoutContainer\n");
    else printf("\nContainerState: ContainerStateInMainView\n");
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	
    [super touchesBegan:touches withEvent:event];
    
    printf("began");
    
    [self logState]; /*Just to track the container state.*/
    
    layoutContainer = nil; /*Reset the Layout container.*/
    
    location = [[touches anyObject] locationInView:self];
    mainViewLocation = [[touches anyObject] locationInView:[owner_ view]];
    [[owner_ clientImagesScroller] setScrollEnabled:NO]; 
    
    
    /*Moving from Scrollview to Mainview*/
    if ( [self getContainerState] == ContainerStateInScrollView ) self.center = mainViewLocation;
    else self.center = location;


//    UIImageView *border = [[UIImageView alloc] initWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Border_frame_256w" ofType: @"png"]]];
//    border.frame = self.frame;
//    border.transform = CGAffineTransformMakeScale(1.15, 1.15);
//    [self addSubview:border];
//    [border release];
    
    if ( [self getContainerState] != ContainerStateInMainView ) { /*Only perform animations if we're not in the 
                                                                   main view.*/
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//        [UIView setAnimationDuration:0.25f];
//        [UIView setAnimationDelegate:self];
//        [UIView setAnimationDidStopSelector:@selector(finishedAnimation)];
//        
//        /*Grow just a little to show activation*/
//        if ( _containerState == ContainerStateInScrollView ) self.transform = CGAffineTransformMakeScale(1.15f, 1.15f);
//        
//        /*Otherwise it means we're moving away from a layout spot*/
//        else self.transform = CGAffineTransformIdentity;
//        
//        [UIView commitAnimations];
//    
//        
//        /*This is to keep the image from "running away" from the touch back to its
//         frame origin.*/
//        self.center = mainViewLocation;
//
//    
//        /*When an image is touched, it will move from 
//         either the scrollview or layout container to the
//         main view.*/
//        if ( self.superview != [owner_ view] && [self getContainerState] != ContainerStateInLayoutContainer ) { 
//            [self removeFromSuperview];
//            [[owner_ view] addSubview:self];
//            _containerState = ContainerStateInMainView;
//
//        }

    }
    
    [self logState];

}

- (void)finishedAnimation {}



- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
    [super touchesMoved:touches withEvent:event];
    
        CGPoint point = [[touches anyObject] locationInView:self];
    
        if ( !(self.center.x + self.frame.size.width / 2 >= CGRectGetMaxX(self.superview.frame) ||
            self.center.x - self.frame.size.width / 2 <= CGRectGetMaxX([[self.superview sidePanelView] frame])) )
        {
            float theX = point.x - location.x;
            float theY = point.y - location.y;
            CGPoint newCenter = CGPointMake(self.center.x + theX, self.center.y + theY);
            
            
            self.center = newCenter;
        }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    [[owner_ clientImagesScroller] setScrollEnabled:YES];

    
    for (int i = 0; i < 4; i++) {
        
        if ( CGRectContainsPoint( [[owner_ clientImagesScroller] frame], self.center) ) {
            [self removeFromSuperview];
            [[owner_ clientImagesScroller] addSubview:self];
            self.frame = originalFrame;
            self.transform = CGAffineTransformIdentity;
        }
        
        else if ( [owner_ getLayout:i] && 
            (CGRectContainsPoint( [[owner_ getLayout:i] frame], self.frame.origin) || 
             CGRectContainsPoint( [[owner_ getLayout:i] frame], CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame)) ) ||
             CGRectContainsPoint( [[owner_ getLayout:i] frame], CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMaxY(self.frame)) ) ||
             CGRectContainsPoint( [[owner_ getLayout:i] frame], CGPointMake(CGRectGetMinX(self.frame), CGRectGetMaxY(self.frame)) ) ||
             CGRectContainsPoint( [[owner_ getLayout:i] frame], self.center )
             ) && !layoutContainer) {
                        
//            [self removeFromSuperview];
//            [[owner_ getLayout:i] addSubview:self];
            layoutContainer = [owner_ getLayout:i];
            _containerState = ContainerStateInLayoutContainer;
                
                
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDuration:0.25f];
            
            self.transform = CGAffineTransformIdentity;
                
            CGSize transformScale = [self calculateTransformPercentage: [[owner_ getLayout:i] frame]];
                self.transform = CGAffineTransformMakeScale(transformScale.width, transformScale.height);
//            [self setFrame:[[owner_ getLayout:i] frame]];
            [self setCenter:[[owner_ getLayout:i] center]];
            [self.superview bringSubviewToFront:self];
            
            [UIView commitAnimations];
            
        }
        
        
    }

    _dragState = DragStateDisabled;

    printf("TouchesEnded.");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesCancelled:touches withEvent:event];
    
    printf("\ntouchesCancelled.");
    
}




- (CGSize)calculateTransformPercentage: (CGRect)theRect {
    
    float newWidth = theRect.size.width / self.frame.size.width; /*Calculate what percentage our width is
                                                                   in relation to theRect width.*/
    
    float newHeight = theRect.size.height / self.frame.size.height; /*Same for height.*/
        
    return CGSizeMake(newWidth, newHeight);
}


- (void)reset {
    
        self.transform = CGAffineTransformIdentity;

        [self removeFromSuperview];
        [[owner_ clientImagesScroller] addSubview:self];
    
//        self.frame = originalFrame;
        layoutContainer = nil;
        _dragState = DragStateDisabled;
        _containerState = ContainerStateInScrollView;

    
}

- (BOOL)canBecomeFirstResponder { return YES; }
- (BOOL)canResignFirstResponder { return YES; }

-  (void)dealloc
{
    [longPress release];
    self->longPress = nil;
    
    [super dealloc];
}

@end
