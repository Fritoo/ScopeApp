//
//  AMAppRater.h
//  AMSample
//
//  Created by Miles Alden on 12/21/12.
//
//

#import <Foundation/Foundation.h>



@interface AMAppRater : NSObject <UIAlertViewDelegate>


@property int numAppLaunches;
@property int rated;

- (void)prepare;

@end
