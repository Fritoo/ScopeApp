//
//  InfoPageViewCon.m
//  AMSample
//
//  Created by Miles Alden on 7/14/11.
//  Copyright 2011 Santa Cruz Singers. All rights reserved.
//

#import "InfoPageViewCon.h"
#import "CompareViewAppDelegate.h"
#import "ControlPoint.h"
#import "NSObject+ClassName.h"

@implementation InfoPageViewCon

@synthesize on;

- (void)viewDidLoad
{
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    soundSwitch.on = [del isSoundOn];
    photoRollSwitch.on = [del shouldSaveToCameraRoll];
}

- (IBAction)linkToSTRsite
{
    [[UIApplication sharedApplication] openURL:STR_LINK_URL];
}

- (IBAction)backButton
{
    //Kill info page
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[del controlPoint] killThis:self hasView:YES];
    
    //Load main menu
    [[del controlPoint] loadMainMenu];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (IBAction)finishedInfoPage:(id)sender {
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    [del.window.rootViewController dismissModalViewControllerAnimated:YES];
    
}

- (IBAction)toggleSwitches: (id)sender
{
    CompareViewAppDelegate *del = (CompareViewAppDelegate *)[[UIApplication sharedApplication] delegate];
    int theTag = [sender tag];
    if (theTag == 1) [del setSoundOn: soundSwitch.on];
    if (theTag == 2) [del setShouldSaveToCameraRoll:photoRollSwitch.on];   
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:soundSwitch.on forKey:@"sound"];
    [userDefaults setBool:photoRollSwitch.on forKey:@"saveToRoll"];
    [userDefaults synchronize];
}


- (IBAction)goButton
{
    //Don't send mail if it can't...duh :D
    if ( ![MFMailComposeViewController canSendMail] ) return;	
	
    
	MFMailComposeViewController *emailVC = [[MFMailComposeViewController alloc] init];
	[emailVC setMailComposeDelegate:self];
	[emailVC setSubject:@"School Tech Resources sign up!"];
	[emailVC setToRecipients:@[[NSString stringWithString:@"sales@strscopes.com"]]];
	[emailVC setMessageBody:[NSString stringWithFormat:@"Please sign me up for special deals and promotions from School Technology Resources! \nPlease use this address: %@", emailField.text] isHTML:NO];
    
	[self presentModalViewController:emailVC animated:YES];	

}


#pragma mark -
#pragma mark Mail Delegate 
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{
	//Handle email-send error
	if ( result != MFMailComposeResultSent ) {
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Your email didn't go through"  delegate:self cancelButtonTitle:@"Try Later" otherButtonTitles:@"Retry", nil];
		alert.tag = 1111;
		[alert show];
		[self dismissModalViewControllerAnimated:YES];
        
	}
    
    //Done with mail composer
	else 
    {
		[self dismissModalViewControllerAnimated:YES];
	}
	
}









#pragma mark -
#pragma mark TextField Delegate
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField { return YES; }
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
	[textField becomeFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	
	[textField resignFirstResponder];
	return YES;	
}





#pragma mark -
#pragma mark AlertView Delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex 
{
            
    //Handle user choice for mail failure
	if ( alertView.tag == 1111 ) {
		if (buttonIndex > 0 ) { 
			[self dismissModalViewControllerAnimated:YES]; 
			[self goButton];
		}
		else { [self dismissModalViewControllerAnimated:YES]; }
	}
	
}



@end
