//
//  AMAlertView.h
//  AMSample
//
//  Created by Miles Alden on 12/30/12.
//
//

#import <Foundation/Foundation.h>

@interface AMAlertView : NSObject <UIAlertViewDelegate>

- (void)runAlertViewWithTitle:(NSString *)_title message:(NSString *)_message cancel:(NSString *)_cancel otherButtonTitles:(NSString *[])titles numTitles:(unsigned int)num andDelegate:(id<UIAlertViewDelegate>)_del;


@end
