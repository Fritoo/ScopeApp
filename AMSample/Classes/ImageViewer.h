//
//  ImageViewer.h
//  AMSample
//
//  Created by Miles Alden on 7/20/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageViewer : UIViewController <UIScrollViewDelegate> {
    
    IBOutlet UIImageView *theImage;
    IBOutlet UINavigationBar *theNavBar;
}

- (BOOL)setTheImage_: (NSString *)imagePath;
- (IBAction)backButton: (id)sender;

@end
