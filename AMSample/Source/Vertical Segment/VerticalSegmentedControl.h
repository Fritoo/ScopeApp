//
//  VerticalSegmentedControl.h
//  AMSample
//
//  Created by Miles Alden on 1/25/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerticalSegmentedControl : UIView
{
    /*I'm setting a max of 10 because...who needs more than 10
     segments?*/
    UIButton *partnerButtons[10];
    
}


@property (readonly) int numberOfSegments;
@property (readonly) int selectedSegment;
@property (readonly) float verticalSpacing;
@property (readonly) float verticalHeight;
@property (strong) id delegate;


- (NSString *)stringRepresentationOfNumber: (int)number;
- (UIButton *)segmentAtIndex: (int)segmentIndex;
- (void)setNumberOfSegments:(int)num;
- (void)setVerticalHeight:(float)height;
- (void)setVerticalSpacing:(float)verticalSpacing;
- (void)segment:(int)indexNumber addTarget:(id)target selector:(SEL)selector;
- (void)updateSegments;
- (id)initWithFrame: (CGRect)_frame_ 
   numberOfSegments:(int)numSegments 
    verticalSpacing: (float)vertSpace
     verticalHeight: (float)vertHeight
           delegate: (id)del;

@end
