//
//  Layout.h
//  AMSample
//
//  Created by Miles Alden on 4/2/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Layout : UIView {

    id currentComparableImage;
    
}

@property BOOL hasComparableImage;

- (void)setCurrentComparableImage:(id)curImage;
- (id)currentComparableImage;

@end

