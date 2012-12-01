//
//  MainMenuViewCon.m
//  AMSample
//
//  Created by Miles Alden on 7/13/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import "MainMenuViewCon.h"
#import "ControlPoint.h"
#import "AMSampleAppDelegate.h"
#import "SplashViewCon.h"

@implementation MainMenuViewCon



- (void)viewDidLoad
{
    if ( scView && svContent )
    {
        [scView addSubview:svContent];
        [scView setContentSize:svContent.frame.size];
        [scView setDelegate:self];
    }
    
    self->slideShowTimer = [NSTimer timerWithTimeInterval:SLIDE_SHOW_INTERVAL target:self selector:@selector(changeSlide) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:slideShowTimer forMode:NSDefaultRunLoopMode];
        
    
}







- (void)changeSlide
{
    if (scView)
    {
        CGPoint newPoint;
        
        //check for end of pages
        if ( slidePageControl.currentPage >= NUM_SLIDE_SHOW_PAGES - 1)
        {
            newPoint = CGPointMake(0, scView.contentOffset.y);
            [scView setContentOffset:newPoint animated:YES];

        }
        
        else
        {
            newPoint = CGPointMake((slidePageControl.currentPage * SLIDE_SHOW_PAGE_WIDTH) + SLIDE_SHOW_PAGE_WIDTH, scView.contentOffset.y);
        }
        
        //Change to next slide
        [scView setContentOffset:newPoint animated:YES];

        
        //Update page control
        if ( slidePageControl )
        {
            slidePageControl.currentPage = (int)(scView.contentOffset.x / SLIDE_SHOW_PAGE_WIDTH);        
            [slidePageControl updateCurrentPageDisplay];
        }
    }
}











- (IBAction)galleryButton
{
    [self endMainMenu];
    
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
    [[del controlPoint] loadGallery];
}

- (IBAction)sideBySideButton
{
    [self endMainMenu];
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
    [[del controlPoint] loadSideBySide];
}

- (IBAction)scopeButton
{
    [self endMainMenu];
    
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
    [[del controlPoint] loadScope];

}
- (IBAction)connectionButton{}
- (IBAction)infoButton
{
    [self endMainMenu];
    
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
    [[del controlPoint] loadInfoPage];

 }










- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ( slidePageControl )
    {
        slidePageControl.currentPage = (int)(scView.contentOffset.x / SLIDE_SHOW_PAGE_WIDTH);        
        [slidePageControl updateCurrentPageDisplay];
    }

}



- (void)endMainMenu
{
    if ( slideShowTimer)
    {
        [slideShowTimer invalidate];
        self->slideShowTimer = nil;
    }
    
    AMSampleAppDelegate *del = [[UIApplication sharedApplication] delegate];
    [[del controlPoint] killThis:self hasView:YES];
    
}


    
- (void)dealloc
{
    
    if ( slideShowTimer)
    {
        [slideShowTimer invalidate];
        self->slideShowTimer = nil;
    }

    
    if ( svContent )
    {
        [svContent removeFromSuperview];
        [svContent release];
//        self->svContent = nil;
    }

    if ( scView )
    {
        [scView removeFromSuperview];
        [scView release];
        //        self->svContent = nil;
    }

    if ( slidePageControl )
    {
        [slidePageControl removeFromSuperview];
        [slidePageControl release];
        //        self->svContent = nil;
    }

    [super dealloc];
    
}

@end
