//
//  AMSplashScreen.h
//  AMSample
//
//  Created by Miles Alden on 12/1/12.
//
//

#import "AMObject.h"
#import "AMLogging.h"
#import "AMConstants.h"

@interface AMSplashScreen : UIView {
    
    NSTimer *timer;
}


+ (AMSplashScreen *)viewWithExpiration:(float)lifetime;

@end
