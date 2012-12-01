//
//  MainMenuViewCon.h
//  AMSample
//
//  Created by Miles Alden on 7/13/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MainMenuViewCon : UIViewController <UIScrollViewDelegate> {
    
    IBOutlet UIView *svContent;
    IBOutlet UIScrollView *scView;
    IBOutlet UIPageControl *slidePageControl;
    NSTimer *slideShowTimer;
    
}


- (IBAction)galleryButton;
- (IBAction)scopeButton;
- (IBAction)connectionButton;
- (IBAction)sideBySideButton;
- (IBAction)infoButton;
- (void)endMainMenu;


@end