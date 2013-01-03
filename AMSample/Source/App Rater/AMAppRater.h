//
//  AMAppRater.h
//  AMSample
//
//  Created by Miles Alden on 12/21/12.
//
//

#import <Foundation/Foundation.h>

extern NSString const *APP_RATE;
extern NSString const *NUM_LAUNCH;

@interface AMAppRater : NSObject <UIAlertViewDelegate>


@property int numAppLaunches;
@property int rated;

- (void)prepare;

@end
