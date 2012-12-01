//
//  VerticalSegmentedControl.m
//  AMSample
//
//  Created by Miles Alden on 1/25/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import "VerticalSegmentedControl.h"




@implementation VerticalSegmentedControl

@synthesize numberOfSegments, selectedSegment, verticalSpacing, verticalHeight, delegate;


- (id)initWithFrame: (CGRect)_frame_ 
                       numberOfSegments:(int)numSegments 
                        verticalSpacing: (float)vertSpace
                        verticalHeight: (float)vertHeight
                               delegate: (id)del {
    self = [super initWithFrame:_frame_];
    if ( self != nil ) {
        
        delegate = del;
        verticalSpacing = vertSpace;
        [self setNumberOfSegments:numSegments];
        [self setVerticalHeight:vertHeight];
        [self updateSegments];
    }
    
    return self;
    
}


- (void)setNumberOfSegments:(int)num {
    
    /*Clamp values between 2 and 10.*/
    if ( num < 2 ) numberOfSegments = 2;
    else if ( num > 10 ) numberOfSegments = 10;
    numberOfSegments = num;
    
}

- (void)togglePartnerStates {
    
    for (int i = 0; i < numberOfSegments; i++) {
        if ( partnerButtons[i] && i != selectedSegment) [partnerButtons[i] setSelected:NO];
    }
    
    
}
           
- (void)updateSelectedSegmentIndex:(id)sender {
    
    /*Updates the selected segment variable.*/
    if ( sender ) selectedSegment = [sender tag];
    
    [partnerButtons[ [sender tag] ] setSelected:YES];
    /*Deselects all the rest.*/
    [self togglePartnerStates];
    
}
                                  
                                

- (void)setVerticalHeight:(float)height {
    
    /*Set minimum height to 30 points.*/
    if (height < 30.0f) height = 30.0f;
    verticalHeight = height;
}

- (void)setVerticalSpacing:(float)spacing {
    
    /*Set minimum spacing to 30 points.*/
    if (spacing < 30.0f) spacing = 30.0f;
    verticalSpacing = spacing;
}

- (void)segment:(int)indexNumber addTarget:(id)target selector:(SEL)selector {
    
    /*Test for if that button even exists.*/
    if (!partnerButtons[indexNumber]) return;
    
    [partnerButtons[indexNumber] addTarget:target action:selector forControlEvents:UIControlEventTouchDown];        
}


- (UIButton *)segmentAtIndex: (int)segmentIndex {
    
    UIButton *retVal;
    if ( partnerButtons[segmentIndex] ) retVal = partnerButtons[segmentIndex];
    else retVal = nil;
    
    return retVal;
}

- (void)updateSegments {
    
    
    /*Make the button a stretchable image cap
     for both selected and deselected states.*/
    UIImage *backgroundImage_Selected = [[UIImage imageNamed:@"Segmented_Cap_Stretchable"] stretchableImageWithLeftCapWidth:8 topCapHeight:verticalHeight];
    UIImage *backgroundImage_Deselected = [[UIImage imageNamed:@"Segmented_Cap_Stretchable_deselected"] stretchableImageWithLeftCapWidth:8 topCapHeight:verticalHeight];
    
    
    for (int i = 0; i < numberOfSegments; i++) {
        
        /*Make a frame that fits.*/
        CGRect singleButtonFrame = CGRectMake(0, i * (verticalHeight + verticalSpacing), self.frame.size.width, verticalHeight);

        
        /*If it already exists, reset it.*/
        if ( partnerButtons[i] ) {
            [partnerButtons[i] removeFromSuperview];
            [partnerButtons[i] release];
        }    
        
        
        partnerButtons[i] = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        
        
        /*Do some initialization.*/
        [partnerButtons[i] setTag:i];
        
        [partnerButtons[i] setTitle:[self stringRepresentationOfNumber:i] forState:UIControlStateNormal];
        [partnerButtons[i] setTitle:[self stringRepresentationOfNumber:i] forState:UIControlStateSelected];
        [[partnerButtons[i] titleLabel] setFont:[UIFont boldSystemFontOfSize:verticalHeight / 2]];
        [partnerButtons[i] setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [partnerButtons[i] setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [partnerButtons[i] setShowsTouchWhenHighlighted:NO];
        [partnerButtons[i] setReversesTitleShadowWhenHighlighted:NO];
        [partnerButtons[i] setAdjustsImageWhenHighlighted:NO];
         
        [partnerButtons[i] setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [partnerButtons[i] setBackgroundImage:backgroundImage_Selected forState:UIControlStateSelected];
        [partnerButtons[i] setBackgroundImage:backgroundImage_Deselected forState:UIControlStateNormal];
        [partnerButtons[i] setFrame:singleButtonFrame];
        

        
        [partnerButtons[i] addTarget:self action:@selector(updateSelectedSegmentIndex:) forControlEvents:UIControlEventTouchDown];        
        [self addSubview:partnerButtons[i]];
        
    }
    
    self.frame = CGRectMake(self.frame.origin.x, 
                            self.frame.origin.y, 
                            self.frame.size.width, 
                            (numberOfSegments * (verticalHeight + verticalSpacing)) - verticalSpacing /*We subtract the last vertical spacing since we get one too many.*/  );
    
}


- (NSString *)stringRepresentationOfNumber: (int)number {
    
    NSString *retVal;
    if ( number == 0 ) retVal = @"Single";
    else if ( number == 1 ) retVal = @"Double";
    else if ( number == 2 ) retVal = @"Triple";
    else if ( number == 3 ) retVal = @"Quad";
    
    return retVal;
    
}

@end
