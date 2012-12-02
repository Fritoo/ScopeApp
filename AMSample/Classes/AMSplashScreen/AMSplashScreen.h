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
    float rotation;
    float depth;
}

+ (AMSplashScreen *)viewWithExpiration:(float)lifetime andFrame:(CGRect)frm;
- (void)animateConcurrently;
- (void)startAnimation;

@end
