//
//  InfoPageViewCon.h
//  AMSample
//
//  Created by Miles Alden on 7/14/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>



@interface InfoPageViewCon : UIViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate> {
    
    IBOutlet UITextField *emailField;
    IBOutlet UIView *linkMask;
    IBOutlet UISwitch *soundSwitch, *photoRollSwitch, *gallerySwitch;
    
    
}


@property BOOL on;



- (IBAction)linkToSTRsite;
- (IBAction)backButton;
- (IBAction)goButton;
- (IBAction)toggleSwitches: (id)sender;
- (IBAction)finishedInfoPage:(id)sender;


@end
