//
//  AMAlertView.m
//  AMSample
//
//  Created by Miles Alden on 12/30/12.
//
//

#import "AMAlertView.h"

@implementation AMAlertView


- (void)runAlertViewWithTitle:(NSString *)_title message:(NSString *)_message cancel:(NSString *)_cancel otherButtonTitles:(NSString *[])titles numTitles:(unsigned int)num andDelegate:(id<UIAlertViewDelegate>)_del {
    
    if ( titles == NULL ) {
        titles[0] = @"Yep";
    }
    
    if ( _title == nil ) {
        _title = @"Alert";
    }
    
    if ( _message == nil ) {
        _message = @"Message";
    }
    
    if ( _cancel == nil ) {
        _cancel = @"Nope";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title
                                                    message:_message
                                                   delegate:_del
                                          cancelButtonTitle:_cancel
                                          otherButtonTitles:titles[0], nil];
    
    // Zero should've already been handled above
    for ( int i = 1; i < num; i++ ) {
        if ( titles[i] != nil ) {
            [alert addButtonWithTitle:titles[i]];
        }
    }
    
    
    
//    UILabel *promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(12,40,260,25)];
//    promptLabel.font = [UIFont systemFontOfSize:16];
//    promptLabel.textColor = [UIColor whiteColor];
//    promptLabel.backgroundColor = [UIColor clearColor];
//    promptLabel.shadowColor = [UIColor blackColor];
//    promptLabel.shadowOffset = CGSizeMake(0,-1);
//    promptLabel.textAlignment = UITextAlignmentCenter;
//    promptLabel.text = @"Please enter your code:";
//    [alert addSubview:promptLabel];
    
//    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(16,83,252,25)];
//    field.font = [UIFont systemFontOfSize:18];
//    field.secureTextEntry = YES;
//    field.keyboardAppearance = UIKeyboardAppearanceAlert;
//    field.borderStyle = UITextBorderStyleRoundedRect;
//    field.placeholder = @"Code";
//    [field becomeFirstResponder];
//    [alert addSubview:field];
    
    [alert show];
    
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if ( buttonIndex == 0 ) {
        // Handle cancel
    } else {
        // Handle true or more
    }
    
    
}


@end
