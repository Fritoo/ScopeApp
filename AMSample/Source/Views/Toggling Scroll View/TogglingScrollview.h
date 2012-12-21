//
//  TogglingScrollview.h
//  AMSample
//
//  Created by Miles Alden on 1/29/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TogglingScrollview : UIScrollView
{
    BOOL on;
}

- (BOOL)isOn;
- (void)setOn: (BOOL)val;
- (void)initializeOnState;


@end
