//
//  SaveImageCon.m
//  AMSample
//
//  Created by Miles Alden on 2/13/12.
//  Copyright (c) 2012 Santa Cruz Singers. All rights reserved.
//

#import "SaveImageCon.h"
#import "CompareViewAppDelegate.h"
#import "ControlPoint.h"
#import "SideBySideCon.h"


@implementation SaveImageCon

@synthesize tempImageView, textF, albumTitle, albumManagerCon;



- (void)viewDidLoad {
    
    if (textF) [textF becomeFirstResponder];
    if ( albumManagerCon ) {
        albumManagerCon.mainViewCon = self;
    }

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}


- (IBAction)pressedCancel:(id)sender {
    
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.window.rootViewController dismissModalViewControllerAnimated:YES];

    
}


- (IBAction)pressedSave:(id)sender {
    
    if ( !albumTitle ) albumTitle = DEFAULT_ALBUM;
    
    [textF resignFirstResponder];
    
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.controlPoint.sideBySideCon.liveViewContainer.liveImageView filePictureWithName:textF.text album:albumTitle];
    [del.window.rootViewController dismissModalViewControllerAnimated:YES];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    printf("TextValue");
    
    
    if ( topNavBar ) {
        topNavBar.topItem.title = textField.text;
    }

}

- (IBAction)textFieldDidChangeContent: (id)sender {
    
    if ( topNavBar ) {
        topNavBar.topItem.title = textF.text;
    }

    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    printf("TextValue");
    
    
    if ( topNavBar ) {
        topNavBar.topItem.title = textField.text;
    }
    
    [textF resignFirstResponder];

    return YES;
    
}






@end
