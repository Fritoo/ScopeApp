//
//  ImageViewer.m
//  AMSample
//
//  Created by Miles Alden on 7/20/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import "ImageViewer.h"
#import "CompareViewAppDelegate.h"
#import "ControlPoint.h"

@implementation ImageViewer


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return (scrollView.subviews)[0];
    
}


- (void)viewDidLoad
{
    /*
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:@"arrow_back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButton) forControlEvents:UIControlEventTouchUpInside];
    [backButton setFrame:CGRectMake(20, 20, 44, 44)];
    [self.view addSubview:backButton];
    [self.view bringSubviewToFront:backButton];

     */
}


- (BOOL)setTheImage_: (NSString *)imagePath
{
    
    if ( theNavBar ) {
        theNavBar.topItem.title = [imagePath lastPathComponent];
    }

    if ( theImage && imagePath ){
        [theImage setImage:[UIImage imageWithContentsOfFile:imagePath]];
    }
    
    BOOL retVal;
    if ( theImage.image ) retVal = YES;
    else retVal = NO;
    
    return retVal;
}


- (IBAction)backButton: (id)sender
{
    //Kill info page
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
//    [[del controlPoint] killThis:self hasView:YES];
    
    [del.window.rootViewController dismissModalViewControllerAnimated:YES];
    
    
    //Load gallery
    [[del controlPoint] performSelector:@selector(loadGallery) withObject:nil afterDelay:0.6f];
}

@end
