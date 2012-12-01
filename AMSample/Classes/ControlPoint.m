//
//  ControlPoint.m
//  AMSample
//
//  Created by Miles Alden on 7/15/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import "ControlPoint.h"
#import "AMSampleAppDelegate.h"
#import "ScopeViewCon.h"
#import "MainMenuViewCon.h"
#import "InfoPageViewCon.h"
#import "GalleryViewCon.h"
#import "ImageViewer.h"
#import "SideBySideCon.h"
#import "SaveImageCon.h"


@implementation ControlPoint

@synthesize sideBySideCon;

- (void)killThis: (id)object hasView: (BOOL)hasView
{
    if ( object )
    {
        self->disposalObject = object;
        
        if ( hasView )
        {
            [UIView beginAnimations:@"fadeAnimation" context:nil];
            [UIView setAnimationDuration:0.2];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelegate:self];
            [UIView setAnimationDidStopSelector:@selector(completedAnimation)];
            
            [[disposalObject view] setAlpha:0.0];
            
            [UIView commitAnimations];
        }
        
        else
        {
            [disposalObject release];
            disposalObject = nil;
        }
        
        
    }
}


- (void)completedAnimation
{
    [[disposalObject view] removeFromSuperview];
    [disposalObject release];
    self->disposalObject = nil;
//    printf("objectRetainCount: %d", [disposalObject retainCount]);

}


- (void)loadScope
{
    self->sdkVConWrap = [[ScopeViewCon alloc] initWithNibName:@"ScopeView" bundle:nil];
    [self animateOntoScreen:sdkVConWrap callSetup:NO animationType:AnimationTypeFadeInFromTransparent direction:NavigationDirectionForward];

//    AMSampleAppDelegate *del = [[UIApplication sharedApplication] delegate];
//    [[del window] addSubview:sdkVConWrap.view];
    
}

- (void)loadMainMenu
{
    self->mainMenuCon = [[MainMenuViewCon alloc] initWithNibName:@"MainMenu" bundle:nil];
    [self animateOntoScreen:mainMenuCon callSetup:NO animationType:AnimationTypeFadeInFromTransparent direction:NavigationDirectionForward];

    
//    AMSampleAppDelegate *del = [[UIApplication sharedApplication] delegate];
//    [[del window] addSubview:mainMenuCon.view];
}


- (void)loadInfoPage
{
    if (infoPageCon) {
        infoPageCon.on = NO;
    }
    
    if ( !infoPageCon )
        self->infoPageCon = [[InfoPageViewCon alloc] initWithNibName:@"InfoPage_ipad" bundle:nil];
    
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
    [infoPageCon setModalPresentationStyle: UIModalPresentationFormSheet];
    [del.window.rootViewController presentModalViewController:infoPageCon animated:YES];
    infoPageCon.on = YES;
    
//   [self animateOntoScreen:infoPageCon callSetup:NO animationType:AnimationTypeFadeInFromTransparent direction:NavigationDirectionForward];
    
}


- (void)loadSaveImage {
    
    if ( !saveImageCon )
        self->saveImageCon = [[SaveImageCon alloc] initWithNibName:@"SaveImage_ipad" bundle:nil];
    
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
    if ( del.window.rootViewController.presentedViewController == saveImageCon ) { printf("saveImageCon is already presented.\n\n"); return; }
    
    [saveImageCon setModalPresentationStyle: UIModalPresentationPageSheet];
    [del.window.rootViewController presentModalViewController:saveImageCon animated:YES];

    
}

- (SaveImageCon *)getSaveImageCon {
    return saveImageCon;
}


- (void)loadGallery
{
    
    if ( !galleryCon )
        self->galleryCon = [[GalleryViewCon alloc] initWithNibName:@"GalleryView_iPad" bundle:nil];
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    [galleryCon setModalPresentationStyle: UIModalPresentationFullScreen];
    [del.window.rootViewController presentModalViewController:galleryCon animated:YES];

    
    //[self animateOntoScreen:galleryCon callSetup:NO animationType:AnimationTypeFadeInFromTransparent direction:NavigationDirectionForward];
    
}

- (void)loadSideBySide
{
    
    self->sideBySideCon = [[SideBySideCon alloc] initWithNibName:@"SideBySide_iPad" bundle:nil];
    [self animateOntoScreen:sideBySideCon callSetup:YES animationType:AnimationTypeFadeInFromTransparent direction:NavigationDirectionForward];
    
}

- (void)loadImageViewer: (NSString *)imagePath
{
    if ( !imageViewer )
        self->imageViewer = [[ImageViewer alloc] initWithNibName:@"ImageViewer_ipad" bundle:nil];
    
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];

    
    [imageViewer setModalPresentationStyle: UIModalPresentationFullScreen];
    [del.window.rootViewController presentModalViewController:imageViewer animated:YES];
    [imageViewer setTheImage_:imagePath];
    
//    [self animateOntoScreen:imageViewer callSetup:NO animationType:AnimationTypeFadeInFromTransparent direction:NavigationDirectionForward];
}




- (void)animateOntoScreen: (id)vCon callSetup: (BOOL)shouldCallSetup animationType: (AnimationType)type direction: (NavigationDirection)direction
{
    
    //Only accept subclasses of UIViewController & UIViewController
    if ( ![vCon respondsToSelector:@selector(view)] || ![vCon view] ) return; 
    
    AMSampleAppDelegate *del = (AMSampleAppDelegate*)[[UIApplication sharedApplication] delegate];

    

    
    CGRect screen = [[[[del window] rootViewController] view] bounds]; 
    CGSize size = screen.size;

    
    [[vCon view] setCenter:CGPointMake( (size.width/2) + size.width , size.height/2)];
    [[vCon view] setAlpha:0.0];
    
    [[del window].rootViewController.view addSubview:[vCon view]];    

    
    
    
    [UIView beginAnimations:@"fadeAnimation" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    [[vCon view] setAlpha:1.0];    
    [[vCon view] setCenter:CGPointMake(size.width/2 , size.height/2)];
//    [[vCon view] setTransform:CGAffineTransformIdentity];
    
    [UIView commitAnimations];
    
    
    if (shouldCallSetup && [vCon respondsToSelector:@selector(setup)] ) [vCon setup];

}


@end
